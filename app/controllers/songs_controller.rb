class SongsController < ApplicationController
  use Rack::Flash

  # index
  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  # new
  get '/songs/new' do
    erb :'songs/new'
  end

  # create
  post '/songs' do
    new_song = Song.find_or_create_by(params[:song])
    new_artist = Artist.find_or_create_by(params[:artist])

    if new_artist
      new_song.artist = new_artist
    end
    new_song.genre_ids = params[:genres]
    new_song.save

    flash[:message] = "Successfully created song."
    redirect "/songs/#{new_song.slug}"
  end

  # show
  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end

  # edit
  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end

  patch '/songs/:slug' do
    song = Song.find_by_slug(params[:slug])
    song.update_attributes(params[:song])

    updated_artist = Artist.find_or_create_by(params[:artist])
    song.artist = updated_artist

    song.genre_ids = params[:genres]
    song.save

    flash[:message] = "Successfully updated song."
    redirect "/songs/#{song.slug}"
  end

end
