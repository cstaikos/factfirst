module VotesHelper

  # Pass true for upvote, false for downvote
  # Pass the evidence in question
  # Returns the appropriate button for the given situation
  def vote_button(button_type, evidence)

    # Text to display for link
    vote_text = button_type ? 'upvote' : 'downvote'
    arrow_direction = button_type ? 'up' : 'down'

    # If user is logged out, return link to login page

    if !current_user
      return link_to  content_tag(:i, "", class: "fa fa-arrow-circle-#{arrow_direction} vote-icon #{requires_login}"),
                      # votes_path(vote: {evidence_id: evidence.id, upvote: button_type}),
                      method: :post,
                      remote: false
    end

    # Display either num of upvotes or num of downvotes
    number_to_display = button_type ? evidence.upvotes : evidence.downvotes

    if current_user.already_voted?(evidence)

      # Grab the vote in question
      current_vote = Vote.where(user: current_user, evidence: evidence).first

      # If the vote is the same as the current button, display a delete link
      if current_vote.upvote == button_type
        form_text =   content_tag(:i, "", class: "fa fa-arrow-circle-#{arrow_direction} voted-on")
        form_path =   "/votes/#{current_vote.id}"
        form_method = :delete

      # Otherwise display a change vote link
      else
        form_text =   content_tag(:i, "", class: "fa fa-arrow-circle-#{arrow_direction} opposite-vote")
        form_path =   "/votes/#{current_vote.id}"
        form_method = :patch
      end

    # If they haven't voted yet, return the regular vote buttons
    else
      form_text =   content_tag(:i, "", class: "fa fa-arrow-circle-#{arrow_direction} vote-icon")
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
