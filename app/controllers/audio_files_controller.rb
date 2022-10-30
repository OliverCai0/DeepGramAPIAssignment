require 'bucket'

class AudioFilesController < ApplicationController
  def index
  end
  
  def create
    b = Bucket.new(bucket_name: "deepgramaudio", client: s3)
    if b.bucket_created? && b.object_uploaded?(object_key: params[:data_binary])
      puts "Bucket has been initialized and object uploaded"
    else
      puts "Something went wrong"
    end

    @audio = AudioFile.new(params[:data_binary])
    if @audio.save
      flash[:success] = "Object successfully created"
      redirect_to @audio
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

end
