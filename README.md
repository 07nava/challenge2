# challenge2
Usecase : Using aws cli to get the instance details in json form and process the filtered data and export the filtered data into json form

Pre request : 
1. Install and configure AWS cli
    aws configure
    AWS Access Key ID [None]: xyz
    AWS Secret Access Key [None]: xyz
    Default region name [None]: us-east-1
    Default output format [None]:
2. Get the AWS cli profile <Awsprofile>
3. Get the AWS EC2 instance ID <AwsInstanceid>
Execution commands
 aws-resource.ps1 GetInstance -AwsInstanceid <AwsInstanceid> -AwsRegion <AwsRegion> -Awsprofile <Awsprofile>
eg: aws-resource.ps1 GetInstance -AwsInstanceid i-0ec82bb87085f9191 -AwsRegion us-east-1 -Awsprofile default

