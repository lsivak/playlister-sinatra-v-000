
class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    erb :'songs/new'
  end

  get '/songs/:slug' do
  @song = Song.find_by_slug(params[:slug])
  erb :'/songs/show'
end

post '/songs' do
  @song = Song.create(:name params["name"])
  artist = Artist.create(name: params["artist"]["name"])

  @song.song_genres.create(name: params["song"]["song_genres"]["name"])
  @song.artist = artist
  @song.save

  flash[:message] = "Successfully created song."
redirect to "/songs/#{@song.slug}"
end

get 'songs/:slug/edit' do
    @songs = Song.find(params[:id])
    erb :'/songs/edit'
  end

  get '/songs/:id' do
    @song = Song.find(params[:id])
    erb :'/songs/show'
  end

  post '/songs/:id' do
    @song = Song.find(params[:id])
    @song.update(params["song"])
    if !params["song"]["name"].empty?
      @song.artists << Artist.create(name: params["artist"]["name"])
    end
    redirect to "songs/#{@song.id}"
end
end
