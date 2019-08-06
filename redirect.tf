resource "aws_lb_listener" "frontend_http_https_redirect" {
  load_balancer_arn = concat(aws_lb.application.*.arn, aws_lb.application_no_logs.*.arn)[0]
  port              = "80"
  protocol          = "HTTP"
  count             = var.http_redirect_enabled ? 1 : 0

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
