variable "environment" {
  description = "The name of the environment"
}

variable "dynamodb_table_name"{
    description = "Table name"
 }
 
variable "aws_region"{
    description = "The Amazon Region"
 }

variable "billing"{
    description = "Controls how you are charged for read and write throughput and how you manage capacity. The valid values are PROVISIONED and PAY_PER_REQUEST. Defaults is PROVISIONED"
 }

variable "write_capacity"{
    description = "The number of write units for this table. If the billing_mode is PROVISIONED, this field is required."
 }

variable "read_capacity"{
    description = "The number of read units for this table. If the billing_mode is PROVISIONED, this field is required."
 }
