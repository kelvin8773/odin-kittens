# frozen_string_literal: true
# require 'flickr'

class KittensController < ApplicationController

  def index
    flickr = Flickr.new

    @kittens = Kitten.all

    @kitten_photos = get_flickr_photos(flickr, "", "kittens", "cute, cat, kittens", "date_taken, owner_name", 5)

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

end
