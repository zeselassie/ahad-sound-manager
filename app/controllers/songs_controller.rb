class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  add_breadcrumb :index, :songs_path
  helper_method :length_to_s
  
  # GET /SongCellection
  def index
    @songs = Song.order(sort_column + " " + sort_direction)
  end

  # GET /songs/1
  def show
    add_breadcrumb @song[:name]
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
    add_breadcrumb @song[:format]
  end

  # POST /songs
  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song, notice: 'Song recored was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /songs/1
  def update
    if @song.update(song_params)
      redirect_to @song, notice: 'Song record was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /songs/1
  def destroy
    @song.destroy
    redirect_to songs_url, notice: 'Song record was successfully destroyed.'
  end

  def length_to_s(time_sec)
    time_s = ""
	time_sec = time_sec.to_i
    time_s += "%02d" % (time_sec / (60*60)) + ":" and time_sec %= 3600 if time_sec >= 3600
    time_s += "%02d" % (time_sec / 60) + ":" + "%02d" % (time_sec % 60)
  end
	
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def song_params
      tmp_song_params = params.require(:song).permit(:name, :format, :length, :size)
	  s_params = tmp_song_params
	  s_params[:length] = length_to_i(s_params[:length])
	  s_params[:size] = size_to_i(s_params[:size])
	  s_params
    end
   
    def length_to_i(length)
      a_time = length.scan(/\d+/)
      length_in_sec = a_time[0].to_i * 60 + a_time[1].to_i if a_time.length == 2
      length_in_sec = a_time[0].to_i * 60 * 60 + a_time[1].to_i * 60 + a_time[2].to_i if a_time.length == 3
      length_in_sec
	end

	def size_to_i (size)
	  if size.match(/^\d+\.?\d+$/) then
	    size = Filesize.new(size + "B").to_i
	  else  
	    size = Filesize.from(size).to_i
	  end
   	end

	def sort_column
      Song.column_names.include?(params[:sort]) ? params[:sort] : "name"
	end

	def sort_direction
	  %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	end
end
