output "load_balancer_arn" {
  description = "The ARN of the application load balancer"
  value       = aws_lb.application_load_balancer.arn
}

output "alb_http_listener_arn" {
  description = "The ARN of the HTTP listener"
  value       = aws_lb_listener.alb_http_listener.arn
}

output "alb_https_listener_arn" {
  description = "The ARN of the HTTPS listener"
  value       = aws_lb_listener.alb_https_listener.arn
}

