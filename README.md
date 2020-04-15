# Terraform Exercise

## Exercise 1.

### Deployment

```sh
# first setup AWS credentials
$ export AWS_ACCESS_KEY_ID="[ACCESS_KEY]"
$ export AWS_SECRET_ACCESS_KEY="[SECRET_KEY]"

# then setup terraform
$ terraform init

# check the plan before doing anything
$ terraform plan

# use apply to start terraform or destroy to delete the already created infrastructure
$ terraform apply
$ terraform destroy
```
