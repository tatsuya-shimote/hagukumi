unless Rails.env.test? || Rails.env.development?
  credentials = Aws::Credentials.new(
    ENV['AWS_ACCESS_KEY_ID'],   
    ENV['AWS_SECRET_ACCESS_KEY']
  )

  s3_resource = Aws::S3::Resource.new(region: 'ap-northeast-1', credentials: credentials)
  S3_BUCKET = s3_resource.bucket('hagukumi-user-image')
end