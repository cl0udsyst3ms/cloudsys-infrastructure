# AWS design
  * VPC
  * ECS with ALB
  * RDS (postgres)

## AWS credentials
Set which profile settings you want to use by typing:
```
export AWS_PROFILE=<profile_name>
```

## Re-point terraform.tfstate to S3
Ignore this step if you want to use local state file
```
terraform remote config -backend=s3 -backend-config="bucket=terraform-ligatest-inf-state" -backend-config="key=live/terraform.tfstate" -backend-config="region=eu-west-1"
```

## Check syntax and get terraform files
```
terraform get
```

## Run terraform plan/apply
```
terraform plan -var-file=config/terraform.tfvars -input=false
# optionally plan against one module
terraform plan -target=module.network -var-file=config/terraform.tfvars -input=false
# or resource
terraform plan -target=aws_s3_bucket.terraform_remote_state_bucket -var-file=config/terraform.tfvars -input=false
# if you're happy with plan - apply code
terraform apply -var-file=config/terraform.tfvars -input=false
```

## Destroy infrastructure
```
terraform plan -destroy -target=module.rds -var-file=config/terraform.tfvars
# if you're happy with plan of destruction - execute:
terraform destroy -target=module.rds -var-file=config/terraform.tfvars
# or whole infrastructure
terraform destroy -var-file=config/terraform.tfvars
```

