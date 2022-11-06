class RemovePathUrlFromAudioFile < ActiveRecord::Migration[7.0]
  def change
    remove_column :audio_files, :url_path
  end
end
