# Terraform

## Basic workflow

```sh
terraform init
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
terraform destroy
```

## State

```sh
terraform state list
terraform state show <resource>
terraform state rm <resource>
terraform state mv <src> <dst>
terraform import <resource> <id>
```

## Workspace

```sh
terraform workspace list
terraform workspace new <name>
terraform workspace select <name>
```

## Targeting

```sh
terraform plan -target=<resource>
terraform apply -target=<resource>
```

## Output & variables

```sh
terraform output
terraform output <name>
terraform apply -var="key=value"
terraform apply -var-file="prod.tfvars"
```

## Cleanup

```sh
# remove all null_resource of a specific type from state
for i in $(terraform state list | grep 'null_resource.exec_pgsql'); do
  terraform state rm "$i"
done
```
