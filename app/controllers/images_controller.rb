class ImagesController < ApplicationController

  protect_from_forgery :except => [:create]

  def create
    images   = params[:images]
    movie_id = params[:movie_id]

    gallerry_array = []
    images.each {|image|
      gallerry_array.push(Gallery.new({movie_id: movie_id, image: image }))
    }

    gallerry_array.each{|gallery|
      gallery.save
    }

    @galleries = Gallery.where(movie_id: movie_id)
  end

end
