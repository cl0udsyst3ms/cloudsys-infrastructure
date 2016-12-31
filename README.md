## Init S3 remote state
```
terraform remote config -backend=s3 -backend-config="bucket=terraform-home-inf-state" -backend-config="key=home/terraform.tfstate" -backend-config="region=eu-west-1"*
```

## Run terraform plan
```
terraform plan -var-file=environment/local/terraform.tfvars
terraform plan -destroy -target=module.rds -var-file=environment/local/terraform.tfvars
```
