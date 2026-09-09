provider "aws" {
    region = "ap-south-1"
}

resource "aws_s3_bucket" "website-bucket" {
    bucket = "aoa-devops-project01-static-website"
    force_destroy = true
}

# Disable "Block Public Access" for the S3 bucket
resource "aws_s3_bucket_public_access_block" "website_bucket_access" {
    bucket = aws_s3_bucket.website-bucket.id
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}

# configure the bucket for static web hosting
resource "aws_s3_bucket_website_configuration" "website_config" {
    bucket = aws_s3_bucket.website-bucket.id

    index_document {
        suffix = "index.html"
    }
}

# add the public read policy to the bucket
resource "aws_s3_bucket_policy" "public_read_policy" {
    bucket = aws_s3_bucket.website-bucket.id

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Sid = "PublicReadGetObject"
                Effect = "Allow"
                Principal = "*"
                Action = "s3:GetObject"
                Resource = "${aws_s3_bucket.website-bucket.arn}/*"
            }
        ]
    })
    # Ensure the bucket policy is applied after the public access block is disabled
    depends_on = [aws_s3_bucket_public_access_block.website_bucket_access]
}

# Output the website URL
output "website_url" {
    value = aws_s3_bucket_website_configuration.website_config.website_endpoint
}