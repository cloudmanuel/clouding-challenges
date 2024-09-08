# Challenge 1

## Scenario:

You or someone on your team is creating a lambda funciton that will be/is attached to an API Gateway. Your lambda attempts to run but occurs an error. Unsure of the cause you are tasked with assisting and solving the issue. Remember to review all the resources and code. 

## Reminder, you should attempt to troubleshoot the issue first without looking up anything on google. 

You can try figuring out the issue by just looking at the code or launching the resources and troubleshooting in the console. 

### Ideally it would benefit you if you're newer to see the console and understand it.

 However, please remember that there are possible charged associated with resources. If you decide to launch them, clean up everything afterwards using terraform destroy. 


### Solution:

The solution would be to bump up the timeout value in the lambda resource, typically this is not a "required" value and defaults to 3 seconds, many users will forget because its not required and spend time having to troubleshoot the error. Review the [Terraform Documents] (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function#timeout)

