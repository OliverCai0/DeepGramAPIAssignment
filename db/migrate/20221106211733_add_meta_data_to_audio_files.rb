class AddMetaDataToAudioFiles < ActiveRecord::Migration[7.0]
  def change
    add_column :audio_files, :length_in_seconds, :integer
    add_column :audio_files, :sample_frames, :integer
    add_column :audio_files, :format, :integer
    add_column :audio_files, :bits_per_sample, :integer
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
