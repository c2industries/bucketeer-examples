var AWS = require('aws-sdk');

process.env.AWS_ACCESS_KEY_ID     = process.env.BUCKETEER_AWS_ACCESS_KEY_ID;
process.env.AWS_SECRET_ACCESS_KEY = process.env.BUCKETEER_AWS_SECRET_ACCESS_KEY;
process.env.AWS_REGION            = 'us-east-1';

var s3     = new AWS.S3();
var params = {
  Key:    process.argv[2] || 'hello-env',
  Bucket: process.env.BUCKETEER_BUCKET_NAME,
  Body:   new Buffer('Hello, node.js'),
};

s3.putObject(params, function put(err, data) {
  if (err) {
    console.log(err, err.stack);
    return;
  } else {
    console.log(data);
  }

  delete params.Body;
  s3.getObject(params, function put(err, data) {
    if (err) console.log(err, err.stack);
    else     console.log(data);

    console.log(data.Body.toString());
  });
});
