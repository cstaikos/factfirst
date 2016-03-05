module VotesHelper

  # Pass true for upvote, false for downvote
  # Pass the evidence in question
  # Returns the appropriate button for the given situation
  def vote_button(button_type, evidence)
    
    # Text to display for link
    vote_text = button_type ? 'upvote' : 'downvote'

    # If user is logged out, return link to login page
    return link_to "#{pluralize evidence.upvotes, vote_text}", new_user_session_path if !current_user

    # Display either num of upvotes or num of downvotes
    number_to_display = button_type ? evidence.upvotes : evidence.downvotes

    if current_user.already_voted?(evidence)

      # Grab the current vote's direction (up or down)
      current_vote = Vote.where(user: current_user, evidence: evidence).first

      if current_vote.upvote = button_type
        form_text =   "#{pluralize evidence.upvotes, vote_text} - change vote"
        form_path =   vote_path(vote: {upvote: button_type})
        form_method = :patch
      else
        form_text =   "#{number_to_display} - #{vote_text}d"
        form_path =   "/votes/#{current_vote.id}"
        form_method = :delete
      end

    # If they haven't voted yet, return the regular vote buttons
    else
      form_text =   "#{pluralize number_to_display, vote_text}"
      form_path =   votes_path(vote: {evidence_id: evidence.id, upvote: button_type})
      form_method = :post

    end

    # Return the actual link
    return link_to form_text,
              form_path,
              method: form_method,
              remote: true

  end # end vote_button method


end # end module
