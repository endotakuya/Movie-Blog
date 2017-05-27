class ImagesController < ApplicationController

  protect_from_forgery :except => [:create]

  def create
    images   = params[:images]
    movie_id = params[:movie_id]
    user_id  = params[:user_id]

    gallerry_array = []
    images.each {|image|
      gallerry_array.push(Gallery.new({movie_id: movie_id, image: image, user_id: user_id }))
    }

    gallerry_array.each{|gallery|
      gallery.save
    }

    @galleries = current_user.galleries.where(movie_id: movie_id)
  end

end
