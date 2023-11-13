# softwareone-assignment

How to deploy the infrastructure:
1. Deploy the S3 state bucket and DynamoDB table located in ./global
2. Deploy the network resources located in ./live/network
3. Deploy the RDS resources located in ./live/mysql
4. Deploy the ALB, ASG, EC2 resources located in ./live/services/hello-world-app




   Note: In order to run the code 4 environment variables are set:
   
   AWS_ACCESS_KEY_ID, AWS_SECRET_ACCEESS_KEY,TF_VAR_db_username and TF_VAR_db_password
   
   After the last terraform apply (in the ./live/services/hello-world-app folder) please use the output "alb_dns_name" generated along with the terraform apply to access the simple web application. 
