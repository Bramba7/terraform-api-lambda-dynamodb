resource "aws_api_gateway_rest_api" "UsersAPI" {
  name = "UsersAPI"
description = "This is my Users API GateWay  "


  endpoint_configuration {
    types = ["REGIONAL"]
  }
}