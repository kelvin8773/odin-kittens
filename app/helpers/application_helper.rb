# frozen_string_literal: true

module ApplicationHelper
  def get_flickr_photos(paramaters)
    photos = []
    urls = 'url_q,'

    if !paramaters[:search_text].empty?
      photo_lists = paramaters[:flickr].photos.search(text: paramaters[:search_text],
                                                      tags: paramaters[:tags],
                                                      extras: urls + paramaters[:extras],
                                                      per_page: paramaters[:size],
                                                      privacy_filter: 1)
    elsif !paramaters[:user_id].empty?
      photo_lists = paramaters[:flickr].people.getPhotos(user_id: paramaters[:user_id],
                                                         extras: urls + paramaters[:extras],
                                                         per_page: paramaters[:size],
                                                         privacy_filter: 1)
    end

    photo_lists.each do |list|
      photo = { title: list.title[0..50],
                owner_id: list.owner,
                url: list.url_q,
                date_taken: list.datetaken,
                owner_name: list.ownername }
      photos << photo
    end

    photos
  end

  def get_flickr_user_by_id(flickr, id)
    flickr.people.getInfo(user_id: id)
  end

  def get_flickr_user_by_name(flickr, name)
    user_id = flickr.people.findByUsername(username: name).id
    flickr.people.getInfo(user_id: user_id)
  end
end
