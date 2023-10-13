variable "user_uuid" {
  description = "User UUID"
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "User UUID must be in the format of a standard UUID (e.g., 123e4567-e89b-12d3-a456-426655440000)."
  }
}
variable "bucket_name" {
  type        = string
  description = "The name of the AWS S3 bucket"

  validation {
    condition = can(regex("^([a-z0-9.-]+)$", var.bucket_name))
    error_message = "The bucket name must consist of lowercase letters, numbers, hyphens, and dots."
  }
}