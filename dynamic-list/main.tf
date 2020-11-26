resource "random_pet" "this" {}
resource "random_pet" "that" {}

locals {
  sample = [random_pet.this.id, random_pet.that.id] # <= computed/dynamic values
}

resource "local_file" "foo" {
  count    = length(local.sample)
  content  = local.sample[count.index]
  filename = "foo-${count.index}"
}

resource "local_file" "bar" {
  count    = length(local_file.foo)
  content  = local_file.foo[count.index].content
  filename = "bar-${count.index}"
}

module "foo_files" {
  source   = "./module"
  contents = local.sample
  prefix   = "module-foo"
}

module "bar_files" {
  source   = "./module"
  contents = module.foo_files.files[*].content
  prefix   = "module-bar"
}
