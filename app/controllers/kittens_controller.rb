# frozen_string_literal: true

class KittensController < ApplicationController
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def show
    @kitten = Kitten.find_by(id: params[:format]) || Kitten.first

    respond_to do |format|
      format.html
      format.json { render json: @kitten }
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
      redirect_to kittens_path(@kitten.id)
    else
      render 'new'
    end
  end

  def edit
    @kitten = Kitten.find_by(id: params[:format])
  end

  def update
    @kitten = Kitten.find_by(id: params[:format])

    permitted = params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    if @kitten.update_attributes(permitted)
      flash[:success] = 'Kitten edited!'
    else
      flash[:warning] = 'Kitten did not update'
    end

    redirect_to kittens_path(@kitten.id)
  end

  def destroy
    @kitten = Kitten.find_by(id: params[:format])
    @kitten.destroy
    flash[:success] = 'Kitten deleted!'
    redirect_to root_url
  end
end
