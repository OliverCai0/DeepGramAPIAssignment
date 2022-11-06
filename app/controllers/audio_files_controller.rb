require 'taglib'

class AudioFilesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @audio_files = AudioFile.all
    if params.has_key?(:maximum_duration)
      @audio_files = @audio_files.where(length_in_seconds: ...params[:maximum_duration])
    end
    if params.has_key?(:format)
      @audio_files = @audio_files.where(format: params[:format])
    end
    @audio_files= @audio_files.map {|x| x.as_json({url: rails_blob_path(x.file, disposition: "attachment")})} 
    render json: @audio_files
  end
  
  def create
    puts params
    @audio = AudioFile.create(name: params[:name])
    @audio.file.attach(params[:file])

    if @audio.file.attached? && @audio.file.audio?
      # meta data
        @audio.file.open do |f|
          puts "f path: #{f.path}"
          TagLib::RIFF::WAV::File.open(f.path) do |a|
            @audio.update!(length_in_seconds: a.audio_properties.length_in_seconds)
            @audio.update!(sample_frames: a.audio_properties.sample_frames)
            @audio.update!(format: a.audio_properties.format)
            @audio.update!(bits_per_sample: a.audio_properties.bits_per_sample)
          end
        end
      render json: @audio.as_json({url: rails_blob_path(@audio.file, disposition: "attachment")})
    else
      render status: 500
    end
  end
  
  def show
    @audio_file = params[:name] ? AudioFile.find(name: params[:name]) : AudioFile.find(params[:id])
    render json: @audio_file.as_json({url: rails_blob_path(@audio_file.file, disposition: "attachment")})
  end
end
