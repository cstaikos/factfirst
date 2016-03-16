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

  def query_details
    result = "<h3>Viewing <em>" +
             (params[:category] ? params[:category].capitalize : 'All') +
             "</em> facts, <em>" +
             (params[:sort] ? params[:sort].capitalize : 'Popular') +
             "</em> first"

    if params[:query] && params[:query].length > 3
      result += ", with <em>\"#{params[:query]}\"</em> in the title"
    end

    result += ":</h3>"

    result.html_safe

  end

end
