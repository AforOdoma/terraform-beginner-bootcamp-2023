## Dealing with configuration Drift

## What happens if we loose our state file?
If you loose your statefile, you most likely will have to tear down all your cloud infrastucture manually.
You can use terraform port but it will not work for all cloud resources. You must check the terraforms providers documentation for which resources support import.
 
### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and delete or modifies cloud resource mannually through Clickops.

If we run Terraform plan it will attempt to put our infrastructure back into the expected state fixing Configuration Drift