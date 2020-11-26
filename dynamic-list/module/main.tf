resource "local_file" "this" {
  count    = length(var.contents)
  content  = var.contents[count.index]
  filename = "${var.prefix}-${count.index}"
}
