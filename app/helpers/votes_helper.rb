module VotesHelper

  # Pass true for upvote, false for downvote
  # Pass the evidence in question
  # Returns the appropriate button for the given situation
  def vote_button(is_up_vote, evidence)
    vote_text = is_up_vote ? 'upvote' : 'downvote' # Text to display for link

    return link_to "#{pluralize evidence.upvotes, vote_text}",
            new_user_session_path if !current_user # If user is logged out, should just direct to login page

    if current_user.already_voted?(evidence)

      current_vote = Vote.where(user: current_user, evidence: evidence).first.upvote # Grab the current vote's direction (up or down)

      if current_vote = is_up_vote
        return 'cancel vote'
      else
        return 'change vote'
      end

    else
      # If they haven't voted yet, return the regular vote buttons
      return link_to "#{pluralize evidence.upvotes, vote_text}",
                votes_path(vote: {evidence_id: evidence.id, upvote: is_up_vote}),
                method: :post,
                remote: current_user != nil,
                id: "#{vote_text}_#{evidence.id}"
    end

  end


end
