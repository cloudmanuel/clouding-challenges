# Challenge 3

*Running this Terraform will output Access Key and Secret Key*

If running using github actions, make sure its a private repo! If running locally, be aware and dont leak them anywhere.

## Scenario:

You want to create an s3 bucket and IAM user that has access to the objects in the bucket. Your user has an access key but is getting access denied when attempting to download the sample.txt file. 

(Note: creating a user and access key is not recommended, you should use IAM roles but for this being simplified I made it this way. Please do not paste your access keys anywhere online and delete the user asap when no longer needed)

You can attempt to download the object in console but in order to get the same outcome, you should assume the role of the user being created via the terminal by grabbing the secret and access key in the console.

Use aws configure to set up your terminal with the access key and secret key above. [AWS Short Creds Doc] (https://docs.aws.amazon.com/cli/v1/userguide/cli-authentication-short-term.html)

``` aws s3 cp s3://mybucket/sample.txt ./ ```

It should download the file or attempt to locally.

## Reminder, you should attempt to troubleshoot the issue first without looking up anything on google. 

You can try figuring out the issue by just looking at the code or launching the resources and troubleshooting in the console. 

### Ideally it would benefit you if you're newer to see the console and understand it and how the resources work togther.

 However, please remember that there are possible charged associated with resources. If you decide to launch them, clean up everything afterwards using terraform destroy. 


### Solution:

The S3 bucket policy has a deny statement for the specific user even though the IAM policy attached to the user has full s3 access. AWS uses least priviledge when evaluating. Review the [AWS Documents] (https://docs.aws.amazon.com/AmazonS3/latest/userguide/security-best-practices.html)