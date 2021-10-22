class VideoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  process :convert => 'mp4'
  process :tags => ['movie_picture']
  def extension_allowlist
     %w(mp4)
  end
  def public_id
    return model.id
  end  
  
end
