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
key    = ARGV[0] || 'hello-global'
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
