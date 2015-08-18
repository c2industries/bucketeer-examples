require 'bundler/setup'
require 'aws-sdk'

# In your bootstrapping / configuration
ENV['AWS_ACCESS_KEY_ID']     = ENV['BUCKETEER_AWS_ACCESS_KEY_ID']
ENV['AWS_SECRET_ACCESS_KEY'] = ENV['BUCKETEER_AWS_SECRET_ACCESS_KEY']
ENV['AWS_REGION']            = 'us-east-1'

s3     = Aws::S3::Client.new
key    = ARGV[0] || 'hello-env'
bucket = ENV['BUCKETEER_BUCKET_NAME']

s3.put_object(
  acl: 'private',
  bucket: bucket,
  key: key,
  body: 'world',
)

resp = s3.get_object(
  bucket: bucket,
  key: key
)

puts resp.body.read
