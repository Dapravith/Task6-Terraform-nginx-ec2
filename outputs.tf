output "ec2_IP" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.developer_portfolio_server.public_ip
}