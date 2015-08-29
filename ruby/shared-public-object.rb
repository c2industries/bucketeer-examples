require 'bundler/setup'
require 'aws-sdk'

# In your bootstrapping / configuration
creds = Aws::Credentials.new(
  ENV['BUCKETEER_AWS_ACCESS_KEY_ID'],
  ENV['BUCKETEER_AWS_SECRET_ACCESS_KEY']
)
Aws.config[:credentials] = creds
Aws.config[:region]      = 'us-east-1'

# wherever you need a client
s3     = Aws::S3::Client.new

# NOTE: All we have to do is use the public prefix
key    = ENV['BUCKETEER_BUCKET_PREFIX'] + "public/" + (ARGV[0] || 'hello-global')
bucket = ENV['BUCKETEER_BUCKET_NAME']

s3.put_object(
  bucket: bucket,
  key: key,
  body: 'world',
)

resp = s3.get_object(
  bucket: bucket,
  key: key
)

url = "https://#{bucket}.s3.amazonaws.com/#{key}"
puts "At: #{url}"
puts resp.body.read
