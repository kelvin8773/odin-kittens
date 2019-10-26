class PagesController < ApplicationController

  def info
    flickr = Flickr.new
    if params[:search] || params[:user_id]
      input = params[:user_id] || params[:search][:input]
      if input.match(/\d*@\S*/)
        @people = get_flickr_user_by_id(flickr, input)
      else
        @people = get_flickr_user_by_name(flickr, input)
      end
      @photos = get_flickr_photos(flickr, @people.id, "", "", "date_taken, owner_name", 99)
    end


  end

  def gallery
  end
end
