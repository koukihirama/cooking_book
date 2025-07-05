require 'aws-sdk-s3'

Aws.config.update(s3_use_checksum: false)