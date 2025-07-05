require "active_storage/service/s3_service"

module ActiveStorageChecksumPatch
  def upload(key, io, checksum: nil, **options)
    super(key, io, checksum: nil, **options) # ← 明示的に checksum を nil に
  end
end

ActiveStorage::Service::S3Service.prepend(ActiveStorageChecksumPatch)