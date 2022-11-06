class AudioFile < ApplicationRecord
  has_one_attached :file

  def as_json(options)
    opts = {
      :file_name => self.name,
      :length_in_seconds => self.length_in_seconds,
      :sample_frames => self.sample_frames,
      :bits_per_sample => self.bits_per_sample,
      :format => self.format
    }
    options.merge(opts)
  end
end
