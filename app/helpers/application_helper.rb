# frozen_string_literal: true

module ApplicationHelper

  def get_flickr_photos(flickr, user_id, search_text, tags, extras, size)
    photos = []
    urls = "url_q,"

    if !search_text.empty?
      photo_lists = flickr.photos.search(text: search_text, tags: tags, extras: urls + extras, per_page: size, privacy_filter: 1)
    elsif !user_id.empty?
      photo_lists = flickr.people.getPhotos(user_id: user_id, extras: urls + extras, per_page: size, privacy_filter: 1)
    end

    photo_lists.each do |list|
      photo = { title: list.title[0..50],
                owner_id: list.owner,
                url: list.url_q,
                date_taken: list.datetaken,
                owner_name: list.ownername
              }
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
