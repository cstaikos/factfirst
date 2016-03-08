module FactsHelper

  def favorite_button (fact)

    if !current_user || current_user.favorites.exists?(fact) == false
      link_to 'WATCH',
              create_favorite_path(fact),
              method: :post,
              remote: !!current_user
    else
      link_to 'UNWATCH',
              destroy_favorite_path(fact),
              method: :delete,
              remote: true
    end

  end

end
