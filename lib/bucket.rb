class Bucket
  attr_accessor :bucket_name
  attr_accessor :client

  def initialize(bucket_name:, client:)
    @bucket_name = bucket_name
    @client= client
  end

  def bucket_created?
    response = client.create_bucket(bucket: bucket_name)
    if response.location == '/' + bucket_name
      return true
    else
      return false
    end
    rescue StandardError => e
      puts "Error creating bucket: #{e.message}"
      return false
  end

  def object_uploaded?(object_key:)
    response = client.put_object(
      bucket: bucket_name,
      key: object_key
    )
    if response.etag
      return true
    else
      return false
    end
    rescue StandardError => e
      puts "Error uploading object: #{e.message}"
      return false
  end

end