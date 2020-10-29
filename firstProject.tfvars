
######################### 
# General Parameters
#########################
environment = "Bramba"
vpc_cidr = "10.0.0.0/16"
sub_cidr = "10.0.0.0/24"
aws_region = "us-west-2"

######################### 
# dynamodb parameters
#########################

dynamodb_table_name = "Users"
billing = "PROVISIONED" 
write_capacity = "20"
read_capacity  = "20"

######################### 
# Lambda
#########################
timeout_lambda = "3"


######################### 
# API gateway           
#########################