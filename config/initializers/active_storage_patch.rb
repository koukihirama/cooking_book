Rails.application.config.to_prepare do
  ActiveStorage::Service::S3Service.class_eval do
    private def upload_with_checksum(key, io, checksum, **options)
      upload_without_checksum(key, io, **options)
    end

    alias_method :upload_without_checksum, :upload
    alias_method :upload, :upload_with_checksum
  end
end