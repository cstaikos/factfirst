module FactsHelper

  def favorite_button

    if current_user.favorites.exists?(@fact)
      link_to 'UNWATCH',
              destroy_favorite_path(@fact),
              method: :delete,
              remote: true
    else
      link_to 'WATCH',
              create_favorite_path(@fact),
              method: :post,
              remote: true
    end

  end

end
