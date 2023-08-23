# initial state

Four directories containing Terraform files describing a VPC and an Instance as Null Provider Resources for two environments `staging` and `prod`.

- `environments/prod/vpc`
- `environments/prod/ec2-instance`
- `environments/staging/vpc`
- `environments/staging/ec2-instance`

# world with terramate

- rename terramate config to disable production safeguards for this demo
  - `cp terramate.tm.hcl.example terramate.tm.hcl`
- create stacks by detecting terraform configuration
  - `terramate create --all-terraform`
  - This will create a `stacks.tm.hcl` in each directory giving each stack a name and an unique ID (UUID)
- validate stacks are detected by listing them
  - `terramate list`
- commit the new found configuration for Terramate Stacks
  - `git add -A && git commit -m 'feat: initialize Terramate stacks'`
- initialize terraform in all stacks an validate the configuration
  - `terramate run -- terraform init`
  - `terramate run -- terraform validate`
  - The Terramate configuration in `terramate.tm.hcl` ensures that we cache the providers in a `.tf_plugin_cache_dir` by setting the Terraform environment variable `TF_PLUGIN_CACHE_DIR`. This speeds up `terraform init` phase as each provider version is downloaded only once.
  - We can ignore the deprecation warning as we use the depricated null data source for demo reasons.
- run a plan in all stacks
  - `terramate --log-level info run -- terraform plan`
  - log level info enables printing the name of the stack being executed for each stack available
  - Note: Outputs and logging will be improved in one of the next upcoming releases
- apply all stacks to the local state backend
  - `terramate --log-level info run -- terraform apply -auto-approve`

# restructuring

## problems

- backend config is code duplication
- providers config is code duplication
- updating providers is annoying and complicated
- the environment needs to be set per stack but could be identified based on hierarchy

## solutions:

### generate backend

- `generate_backend.tm.hcl.example` rename to enable backend generation
- run `terramate generate` to generate `gen_backend.tf` in each directory
- run `terramate run -- rm backend.tf` to remove old config

### generate providers

- `generate_providers.tm.hcl.example` rename to enable providers generation
- run `terramate generate` to generate `gen_providers.tf` in each directory
- run `terramate run -- rm providers.tf` to remove old config
- set global `tf_provider_null_version_constraint` on any level e.g. in stack or per environment in a e.g. `/environments/prod/config.tm.hcl` file:
  ```hcl
  globals {
    tf_provider_null_version_constraint = "3.2.1"
  }
  ```
- run `terramate generate` again to show changes

### set and export globals as locals

- `export_globals_as_locals.tm.hcl.example` rename to enable globals export as locals
- run `terramate generate` to generate `gen_locals.tf`
- adjust code to use generated locals instead of hard coded values when calling modules.
- run `terramate run -- terraform plan` to validate config is still valid and did not change

# maintenance

when creating new stacks with the configs enabled, auto generation will always happen and stacks are initialized and ready to go without manually setting up things.
