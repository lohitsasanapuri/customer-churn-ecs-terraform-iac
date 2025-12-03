output "alb_dns_name" {
  description = "ALB URL"
  value       = aws_lb.app.dns_name
}
