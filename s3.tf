resource "aws_s3_bucket" "terraform_remote_state_bucket" {
    bucket = "terraform-ligatest-inf-state"
    acl = "private"

    tags {
        Name = "terraform-ligatest-inf-state"
        Environment = "Live"
    }
}

resource "aws_s3_bucket" "ligatest_scripts_bucket" {
    bucket = "ligatest-user-data-scripts"
    acl = "private"

    tags {
        Name = "ligatest-user-data-scripts"
        Environment = "Live"
    }
}
