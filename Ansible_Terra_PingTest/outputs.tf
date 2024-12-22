output "ansible_controller_ip" {
  value = aws_instance.ansible_controller.public_ip
}

output "target_1_ip" {
  value = aws_instance.target_1.public_ip
}

output "target_2_ip" {
  value = aws_instance.target_2.public_ip
}
