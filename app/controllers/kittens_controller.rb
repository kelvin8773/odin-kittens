# frozen_string_literal: true
# require 'flickr'

class KittensController < ApplicationController

  def index
    @kittens = Kitten.all

    @kitten_photos = get_flickr_photos("kittens", 3)

    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def show
    @kitten = Kitten.find_by(id: params[:id]) || Kitten.first

    respond_to do |format|
      format.json { render json: @kitten }
      format.html
    end

  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(name: params[:kitten][:name],
                         age: params[:kitten][:age],
                         cuteness: params[:kitten][:cuteness],
                         softness: params[:kitten][:softness])
    if @kitten.save
      flash[:success] = 'Kitten created!'
      redirect_to kittens_path(id: @kitten.id)
    else
      render 'new'
    end
  end

  def edit
    @kitten = Kitten.find_by(id: params[:id])
  end

  def update
    @kitten = Kitten.find_by(id: params[:id])

    permitted = params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    if @kitten.update_attributes(permitted)
      flash[:success] = 'Kitten edited!'
    else
      flash[:warning] = 'Kitten did not update'
    end

    redirect_to kittens_path(id: @kitten.id)
  end

  def destroy
    @kitten = Kitten.find_by(id: params[:id])
    @kitten.destroy
    flash[:success] = 'Kitten deleted!'
    redirect_to root_url
  end

  private

  def get_flickr_photos(search_text, size)
    flickr = Flickr.new
    photos = []

    photo_lists = flickr.photos.search(api_key: ENV["FLICKR_API_KEY"], text: search_text, privacy_filter: 1, tags: "animal")

    random_ids = Array.new(size) { rand(99) }

    random_ids.each do |id|
      photo_info = flickr.photos.getInfo(photo_id: photo_lists[id].id)
      people_info = flickr.people.getInfo(user_id: photo_lists[id].owner)

      photo = { title: photo_info.title[0..50],
                description: photo_info.description,
                date_taken: photo_info.dates.taken,
                owner_description: people_info.description.size < 200 ? people_info.description : "To continue ...",
                profile_url: people_info.profileurl,
                url: Flickr.url_b(photo_info),
                owner_name: people_info.methods.include?(:realname) ? people_info.realname : people_info.username,
                owner_location: people_info.methods.include?(:location) ? people_info.location : "Earth",
                owner_timezone: people_info.methods.include?(:timezone) ? people_info.timezone.timezone_id : "GMT"
              }

      photos << photo
    end
    photos
  end

end
