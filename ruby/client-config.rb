require 'bundler/setup'
require 'aws-sdk'

# build the client in place
creds  = Aws::Credentials.new(ENV['BUCKETEER_AWS_ACCESS_KEY_ID'], ENV['BUCKETEER_AWS_SECRET_ACCESS_KEY'])
s3     = Aws::S3::Client.new(credentials: creds, region: 'us-east-1')
key    = ARGV[0] || 'hello-client'
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
