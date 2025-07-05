require "active_storage/service/s3_service"

Rails.application.config.to_prepare do
  ActiveStorage::Service::S3Service.class_eval do
    private

    def upload(key, io, checksum: nil, **options)
      super(key, io, **options) # checksum を渡さずにオーバーライド
    end
  end
end