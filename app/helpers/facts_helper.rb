module FactsHelper

  def favorite_button

    if current_user.favorites.includes(@fact)
      link_to 'UNWATCH',
              destroy_favorite_path(@fact),
              method: :delete,
              remote: true
    else
      link_to 'WATCH',
              fact_favorites_path(@fact),
              method: :post,
              remote: true
    end

  end

end
