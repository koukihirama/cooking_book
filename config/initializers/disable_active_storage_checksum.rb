Rails.application.config.to_prepare do
  module ActiveStoragePatch
    def extract_metadata(io, analyze: true)
      # Rails 7.2 では metadata 取得時に checksum を強制しているため、ここで上書き
      { filename: filename, content_type: content_type, identified: identified, analyzed: analyze, byte_size: io.size }
    end
  end

  ActiveStorage::Blob.prepend(ActiveStoragePatch)
end