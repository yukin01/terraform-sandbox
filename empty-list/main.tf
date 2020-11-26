locals {
  list_a = []
  list_b = false ? [] : []
  list_c = false ? [""] : []
}
output "list_a" {
  value = local.list_a
}
output "list_b" {
  value = local.list_b
}
output "list_c" {
  value = local.list_c
}
output "list_a_is_empty" {
  value = local.list_a == []
}
output "list_b_is_empty" {
  value = local.list_b == []
}
output "list_c_is_empty" {
  value = local.list_c == []
}
