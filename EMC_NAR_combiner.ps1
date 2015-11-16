<#
.DESCRIPTION
  	This script combines multiple NAR files from a source location and combines them automatically into one 'bundle'
	  It can take some time to run depending on the amount and size of the source NAR files.
	  Requires PowerShell and NavisecCLI
.NOTES
  	Version:        1.0
  	Author:         Brett Sinclair
  	Github:         http://www.github.com/brett-sinclair
  	Twitter:        @Pragmatic_IO
  	Website:        http://www.pragmaticio.com
#>
# Define the source and output directories
$target = 'C:\EMCFILES\Completed\'
$source = 'C:\EMCFILES\Source\'
# Enumerate the input files and loop through a naviseccli combine operation then save out
ls $source\*.nar | sort Mode, Name |ft Name -Au -Hi | out-file $source\source.txt
(GC $source\source.txt  | Select-object -Skip 1) | SC $source\source.txt
$newname = ((gc $source\source.txt)[0].substring(0,29))+".nar"
$mover=(get-content $source\source.txt -totalcount 1);move-item $source\$mover $target\results.nar 
 ForEach ($nar in (gc $source\source.txt)){
                remove-item $target\temp.nar -confirm:$false -EA SilentlyContinue
                naviseccli -h arrayaddress analyzer -archivemerge -data $target\results.nar $source\$nar -out $target\temp.nar -overwrite y
                  if (Test-Path $target\temp.nar){
                    copy-item $target\temp.nar $target\results.nar }}      
# Cleanup directories.
rename-item $target\results.nar $newname
remove-item c:\EMCFILES\Source\* -recurse
