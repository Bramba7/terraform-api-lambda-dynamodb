
######################### 
# General Parameters
#########################
environment = "Bramba"
vpc_cidr = "10.0.0.0/16"
public1_sub_cidr = "10.0.1.0/24"
public2_sub_cidr = "10.0.2.0/24"
private1_sub_cidr = "10.0.3.0/24"
private2_sub_cidr = "10.0.4.0/24"
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
timeout_lambda = "5" 
memory_size = "128"

######################### 
# API gateway           
#########################