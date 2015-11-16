<#
.DESCRIPTION
  	This script copies a VNX array config file for single or multiple Storage Arrays and saves it locally.
	Requires PowerShell and NavisecCLI. Assumes that a security file exists so credentials are not required.
.NOTES
  	Version:        1.0
  	Author:         Brett Sinclair
  	Github:         http://www.github.com/brett-sinclair
  	Twitter:        @Pragmatic_IO
  	Website:        http://www.pragmaticio.com
#>
#For a single array enter only one hostname/IP address
$arrays = @("array1sp","array2sp")
#Loop and save config out. Change output location as required.
Foreach ($arraysp in $arrays) {
$configName = $arraysp+"_"+$(date -f ddMMyyyy)+".xml" ; naviseccli -h $arraysp arrayconfig -capture -output c:\CriticalConfigs\ArrayConfigs\$configName }
