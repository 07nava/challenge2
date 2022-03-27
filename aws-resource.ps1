[CmdletBinding()]
param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('GetInstance','GetSubnet')]
        [string]$Option,
        [Parameter(Mandatory = $true)]
        [String]  $AwsInstanceid="",
        [Parameter(Mandatory = $true)]
        [String]  $AwsRegion="",
        [Parameter(Mandatory = $true)]
        [String]  $Awsprofile=""
     )
 $invocationPath= split-path -parent $MyInvocation.MyCommand.Definition
 . "$invocationPath\aws\Common-Functions.ps1"
try
{
    $logFile = "log\$Option.log"
    $logFilePath =-join($invocationPath,"\",$logFile)
    Create-File -filePath $logFilePath
	Switch ($Option)
     {
        'GetInstance'
        {
         Write-Log "Performing GetInstance action"
         Get-aws-instance-details
        }

        'GetSubnet'
        {
         Write-Log "Performing GetSubnet action"
         Get-aws-subnet-details
        }
     }
 }
  catch
{
	Write-Log "Error while installing $Option : $($_.Exception.Message) " -level "Error"
}