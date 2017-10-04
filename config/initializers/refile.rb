require "refile/s3"

aws = {
	access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
	secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
	region: ENV.fetch('AWS_REGION'),
	bucket: ENV.fetch('S3_BUCKET_NAME'),
}

Refile.cache = Refile::S3.new(max_size: 3.megabytes, prefix: "cache", **aws)
Refile.store = Refile::S3.new(prefix: "store", **aws)
#Refile.store = Refile::S3.new(max_size: 4.megabytes, **aws)
