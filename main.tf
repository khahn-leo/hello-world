resource "aws_s3_bucket" "test" {
  bucket = "prisma-iac-test-bucket"
}

resource "aws_s3_bucket_public_access_block" "test" {
  bucket                  = aws_s3_bucket.test.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_security_group" "open_ssh" {
  name = "open-ssh"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-12345678"
  instance_type = "t3.micro"
  metadata_options {
    http_tokens = "optional"
  }
}