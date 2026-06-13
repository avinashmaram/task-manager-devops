output "app_public_ip" {
  value = aws_instance.app.public_ip
}
output "db_endpoint" {
  value = aws_db_instance.postgres.endpoint
}
output "s3_bucket" {
  value = aws_s3_bucket.storage.bucket
}