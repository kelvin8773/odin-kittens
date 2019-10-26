# frozen_string_literal: true

class PagesController < ApplicationController
  def info
    flickr = Flickr.new
    return unless params[:search] || params[:user_id]

    input = params[:user_id] || params[:search][:input]

    @people = input.match(/\d*@\S*/) ? get_flickr_user_by_id(flickr, input) : get_flickr_user_by_name(flickr, input)

    paramaters = { flickr: flickr,
                   user_id: @people.id,
                   search_text: '',
                   tags: '',
                   extras: 'date_taken, owner_name',
                   size: 99 }

    @photos = get_flickr_photos(paramaters)
  end

  def gallery; end
end
