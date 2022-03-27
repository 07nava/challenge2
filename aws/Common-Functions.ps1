####  Create File #########
function Create-File
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$false)] [string]$filePath
    )


      if (!(Test-Path $filePath))
       {
            Write-Verbose "Creating $logfilePath."
            New-Item $logfilePath -Force -ItemType File
       }
 }
###  Write Log #########
function Write-Log
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true) ] [ValidateNotNullOrEmpty()] [string]$message,

        [Parameter(Mandatory=$false)] [ValidateSet("Error","Warn","Info")] [string]$level="Info"
    )

    Begin
    {
        $VerbosePreference = 'Continue'
    }
    Process
    {
       switch ($Level)
       {
            'Error'
             {
                Write-Error $message
                $LevelText = 'ERROR:'
             }
            'Warn'
            {
                Write-Warning $message
                $LevelText = 'WARNING:'
            }
            'Info'
            {
                Write-Verbose $message
                $LevelText = 'INFO:'
            }
        }
               "$FormattedDate $LevelText $message" | Out-File -FilePath $logfilePath -Append
    }
    End
    {
    }
}

function Get-aws-instance-details
{

try {
    $scriptPath = $invocationPath
    # $instancedetailsjsonpath = -join($scriptPath,"\instance_details.json")
    $outputjson = -join($scriptPath,"\instance_details_output.json")
    # $instancedetailsjsonpath = "C:\Users\Navamaniraj\Documents\test.json"
    aws ec2 describe-instances --instance-ids $AwsInstanceid --profile $Awsprofile --region $AwsRegion --output json > $instancedetailsjsonpath
    if(!(Test-Path $instancedetailsjsonpath)) {throw}
    $instancedetailsContent = Get-Content $instancedetailsjsonpath -Raw | ConvertFrom-Json
    $aws_instance_id	= $instancedetailsContent.Reservations.Instances.InstanceId
    $aws_instance_imageId = $instancedetailsContent.Reservations.Instances.ImageId
    $aws_instance_private_ip = $instancedetailsContent.Reservations.Instances.PrivateIpAddress
    $aws_instance_public_ip = $instancedetailsContent.Reservations.Instances.PublicIpAddress
    $aws_instance_type = $instancedetailsContent.Reservations.Instances.InstanceType

# ####instance details variables#####
    $jsonBase = @{}
    $instance_details = @{"aws_instance_id"=$aws_instance_id;"aws_instance_imageId"=$aws_instance_imageId;"aws_instance_private_ip"=$aws_instance_private_ip;"aws_instance_public_ip"=$aws_instance_public_ip;"aws_instance_type"=$aws_instance_type}
    $jsonBase.Add("Aws_Ec2_Instance",$instance_details)
    Write-Log "Creating instance detail json..."
    $jsonBase | convertto-json | Set-Content $outputjson
}
catch {
    Write-Log "Error Occured in Get-aws-instance-details function : $($_) " -level "Error"
}
}
