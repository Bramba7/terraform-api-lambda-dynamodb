resource "aws_api_gateway_rest_api" "usersApi" {
  name        = "UsersApi"
  description = "Terraform Serverless Application UsersApi"
  endpoint_configuration {
      types = ["REGIONAL"]
  }
  tags = {
    Name        = "UserApi"
    Environment = var.environment
  }
}

# GET
resource "aws_api_gateway_resource" "user" {
   rest_api_id = aws_api_gateway_rest_api.usersApi.id
   parent_id   = aws_api_gateway_rest_api.usersApi.root_resource_id
   path_part   = "user"
}
resource "aws_api_gateway_resource" "id" {
   rest_api_id = aws_api_gateway_rest_api.usersApi.id
   parent_id   = aws_api_gateway_resource.user.id
   path_part   = "{id}"
}

resource "aws_api_gateway_method" "get" {
   rest_api_id   = aws_api_gateway_rest_api.usersApi.id
   resource_id   = aws_api_gateway_resource.id.id
   http_method   = "GET"
   authorization = "AWS_IAM"
}

resource "aws_api_gateway_integration" "iget" {
   rest_api_id = aws_api_gateway_rest_api.usersApi.id
   resource_id = aws_api_gateway_resource.id.id
   http_method = aws_api_gateway_method.get.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = var.get_uri
}

resource "aws_lambda_permission" "apigw1" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name =  var.get_name
   principal     = "apigateway.amazonaws.com"

   # The "/*/*" portion grants access from any method on any resource
   # within the API Gateway REST API.
   source_arn = "${aws_api_gateway_rest_api.usersApi.execution_arn}/*/*"
}


# Post
resource "aws_api_gateway_method" "post" {
   rest_api_id   = aws_api_gateway_rest_api.usersApi.id
   resource_id   = aws_api_gateway_resource.user.id
   http_method   = "POST"
   authorization = "AWS_IAM"
}

resource "aws_api_gateway_integration" "ipost" {
   rest_api_id = aws_api_gateway_rest_api.usersApi.id
   resource_id = aws_api_gateway_resource.user.id
   http_method = aws_api_gateway_method.post.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = var.post_uri
}

resource "aws_lambda_permission" "apigw2" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = var.post_name
   principal     = "apigateway.amazonaws.com"

   # The "/*/*" portion grants access from any method on any resource
   # within the API Gateway REST API.
   source_arn = "${aws_api_gateway_rest_api.usersApi.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "usersApi" {
   depends_on = [
     aws_api_gateway_integration.iget,
     aws_api_gateway_integration.ipost,
   ]

   rest_api_id = aws_api_gateway_rest_api.usersApi.id
   stage_name  = "test"
}


