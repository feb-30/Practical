resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "chmod 0400 ssh/test; sleep 120;ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key ssh/test -i hosts main.yml -b"
  }
  depends_on = [ aws_instance.instance ]
}