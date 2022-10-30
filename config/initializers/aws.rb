Aws.config.update({
    credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
    region: ENV['AWS_REGION']
 })
 
puts "Region: #{ENV['AWS_REGION']}"

 s3 = Aws::S3::Client.new(
    region: Aws.config[:region],
    credentials: Aws.config[:credentials]
    # ...
  )