# Challenge 2

## Scenario:

You are tasked with creating a DynamoDB and ec2 that can connect to it. However, once the user attempts to connect to it via ssm on the ec2, the conneciton is attempted times out. Unsure if the password, configuration, or networking is incorrect, you troubleshoot the error.

You can connect to the ec2 using ssm connect. You can then attempt connecting to your database by grabbing the endpoint, if you want to use the cli 

``` aws rds describe-db-instances \
  --filters "Name=engine,Values=mysql" \
  --query "*[].[DBInstanceIdentifier,Endpoint.Address,Endpoint.Port,MasterUsername]" 
```

Otherwise, you can find it in the console,then you should be able to try and connect using a command like the following :

``` mysql -h mysql–instance1.123456789012.us-east-1.rds.amazonaws.com  -u mymasteruser -p ```

It should prompt for the password given during deployment in the rds.tf file. 

## Reminder, you should attempt to troubleshoot the issue first without looking up anything on google. 

You can try figuring out the issue by just looking at the code or launching the resources and troubleshooting in the console. 

### Ideally it would benefit you if you're newer to see the console and understand it and how the resources work togther.

 However, please remember that there are possible charged associated with resources. If you decide to launch them, clean up everything afterwards using terraform destroy. 


### Solution:

The solution to confirm that the security groups(SG) are correctly configured. You can see that the inbound SG for the database allows the ec2 SG on the wrong port. Review the [AWS Documents] (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ConnectToInstance.html) 

Additionally, in the doc mentioned above it states which port to use and the [mysql documents] (https://dev.mysql.com/doc/refman/8.4/en/mysql-command-options.html#option_mysql_port) will also show the port used by default if not mentioned. 

Typically, it is good practice to use the -P option during the mysql connection but I left it off on purpose. This is something you will just begin to learn and understand more as time passes and you gain experience with databases. You will understand which port is used for which engine by default, the configuration to ports needed if you dont want to use the default, and typical things to check first. 