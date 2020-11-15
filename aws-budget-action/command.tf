resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "date"
  }
  depends_on = [ aws_budgets_budget.ec2 ]
}