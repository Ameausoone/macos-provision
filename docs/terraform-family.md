# Terraform Tools

## terraform-docs

https://terraform-docs.io/

Automatically generates documentation for Terraform modules directly from the code, making variables, outputs, and other configurable elements more visible.

```shell
terraform-docs markdown table ./
```

This generates a markdown table summarizing variables, outputs, and other key information in a Terraform module.

## Terragrunt

https://terragrunt.gruntwork.io/

Provides a wrapper to manage Terraform infrastructure with less code duplication. Terragrunt simplifies the handling of multiple environments and allows for configuration reuse in a DRY (Don't Repeat Yourself) manner.

```shell
terragrunt apply
```

This applies the Terraform configuration using `terragrunt.hcl` files to automate and centralize common configurations.

## tflint

https://github.com/terraform-linters/tflint

A linting tool for Terraform that helps identify potential issues, enforces best practices, and catches errors early in the development process.

```shell
tflint
```

This runs the linter on your Terraform configuration to identify and fix errors or warnings before applying it.

## tf-summarize

https://github.com/dineshba/tf-summarize

Summarizes the output of Terraform plans or applies, making it easier to understand the changes that will be made to the infrastructure.

```shell
terraform plan -out=tfplan
terraform show -json tfplan | tf-summarize
```

This summarizes the planned changes into a concise and readable format, improving clarity during the review process.
