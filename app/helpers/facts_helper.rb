module FactsHelper

  def favorite_button (fact)

    if !current_user || current_user.favorites.exists?(fact) == false
      link_to content_tag(:i, "", class: "fa fa-star-o unfav"),
              create_favorite_path(fact),
              method: :post,
              remote: !!current_user
    else
      link_to content_tag(:i, "", class: "fa fa-star fav"),
              destroy_favorite_path(fact),
              method: :delete,
              remote: true
    end

  end

end
