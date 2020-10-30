output "get_uri"{
    value = aws_lambda_function.get.invoke_arn
}

output "post_uri"{
    value = aws_lambda_function.put.invoke_arn
}

output "get_name"{
    value = aws_lambda_function.get.function_name
}

output "post_name"{
    value = aws_lambda_function.put.function_name
}