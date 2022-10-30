class AddColumnsToAudioFile < ActiveRecord::Migration[7.0]
  def change
    add_column :audio_files, :name, :string
    add_column :audio_files, :url_path, :string
  end
end
