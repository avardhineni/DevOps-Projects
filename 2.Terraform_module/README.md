# Terraform Modules

- Modules are the main way to package and reuse resource configurations within Terraform.
- Every Terraform configuration has at least one module, known as its root module, which consists of the resource defined in the .tf files in the main working directory.
- A Terraform module (usually the root module of a configuration) can call other modules to include their resources into the configuration.
- Child modules can be called multiple times within the same configuration, and multiple configurations can use the same child module.
- Child modules are re-usable code. 

### Terraform Modules helps to stop creating duplicate resources within an orgranization and saves a lot of coders time.




