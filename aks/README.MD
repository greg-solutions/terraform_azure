
## Prepare env
* Create secret.tfvars
* Set `kubernetes_client_id` and `kubernetes_client_secret` to the secret.tfvars
* Execute `terraform init` for download required providers
* Execute `terraform get` for download module dependencies

## Apply terraform
*  Execute `terraform plan -var-file=secret.tfvars` for download required providers
*  Execute `terraform apply -var-file=secret.tfvars` for download required providers


#### Create Client ID and Client Secret
* https://www.terraform.io/docs/providers/azurerm/auth/service_principal_client_secret.html


## Reference

### Azure

- provider: https://www.terraform.io/docs/providers/azurerm/

- example: https://github.com/terraform-providers/terraform-provider-azurerm/tree/master/examples

### Terraform

- terraform syntax: https://www.terraform.io/docs/configuration/syntax.html

- iterpolation: https://www.terraform.io/docs/configuration/interpolation.html