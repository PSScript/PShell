#Requires -module activedirectory
Import-module ActiveDirectory
$Domains = (Get-ADForest).Domains
$PDCs = @()
Foreach ($Domain in $Domains)
{
$PDCs += (Get-ADDomain -Identity $Domain).PDCEmulator
}
Write-Verbose -Message "PDCs Gathered - $($PDCs.count). Processing Workflow." -Verbose
WorkFlow Get-ServerList
{
Param(
[Parameter(Mandatory=$true)][String[]]$PDCs,
[Parameter(Mandatory=$false)]
[ValidateScript({
If(!($PropertiesArray.count -gt 0))
{
Write-Warning "Must be an array"
}Else
{
$True
}
})]
#[Array]$PropertiesArray
[String[]]$PropertiesArray
)
If(!$PropertiesArray)
{
$PropertiesArray = @("dnshostname"
"operatingsystem")
}
Foreach -Parallel ($PDC in $PDCs)
{
Get-ADComputer -Filter {enabled -eq "true" -and OperatingSystem -Like '*Windows Server*'} -Properties $PropertiesArray -Server $PDC -ResultPageSize 1
}
}
$Results = Get-ServerList -PDCs $PDCs
Write-Verbose -Message "$($Results.Count) Gathered." -Verbose