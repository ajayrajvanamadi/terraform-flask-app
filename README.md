### PROJECT NAME: Sample flask app deployed on AWS using terraform

### Tools Used:
AWS - Cloud provider
Python - Language used for the web service
Terraform - IAC
### Setup:
Run terraform apply with replacing some of the values below.
AWS access key ID
AWS secret access key
Public IP in the security groups section in main.tf file.
### Project Files
main.tf - terraform IAC file
tracer.py - Web service code
script.sh - bash script that will install all dependencies and starts the service
mykey and mykey.pub - Keys used for remote connection
### Caveats
This project uses python inbuilt dictionary as the storage. It is durable as long as the service is up abd running. Once the service is restarted 
all the data is lost. No database is used for this project as I didn't see any real requirement. Will require a database if the service has frequent
stops and restarts.
### Assumptions:
Service will be up and running all the time just for durability. 

### KV service description.
This is a simple key value service with the following methods 
/get return the entire dictionary 
/get/key returns the value of the given key 
/post/key/value sets a value for the given key 
/delete deletes the given key from the dictionary