class CreateAudioFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :audio_files do |t|

      t.timestamps
    end
  end
end
