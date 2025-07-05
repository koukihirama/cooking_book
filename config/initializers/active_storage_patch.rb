require "active_storage/service/s3_service"

Rails.application.config.to_prepare do
  ActiveStorage::Service::S3Service.class_eval do
    private def upload_with_disabled_checksum(key, io, checksum: nil, **options)
      upload_without_checksum(key, io, **options)
    end

    alias_method :upload_without_checksum, :upload
    alias_method :upload, :upload_with_disabled_checksum
  end
end