﻿$MBX = get-mailbox -ResultSize unlimited

$privacymode = "Opt-Out"
$OptOutUsers =  @()
$OptInUsers = @()
$failed = @()

# disable for all Users

Foreach ($M in $mbx.userprincipalname) {
If((Get-UserAnalyticsConfig -Identity $M).PrivacyMode -eq 'Opt-Out') { 
write-Host "User $($M) already opted out" -F green } else {
Try { Set-UserAnalyticsConfig -Identity $M -PrivacyMode $privacymode -EA 'stop' ; 
Write-host "[Mailbox] $M set to $($privacymode)" -F green } catch { 
Write-host $error[0].Exception.Message -F Yellow ; $failed+= $M  }
If((Get-UserAnalyticsConfig -Identity $M).PrivacyMode -eq 'Opt-Out') { 
Write-host "[Mailbox] $M set to $($privacymode) confirmed" -F cyan ; 
$OptOutUsers += $M } else { $OptInUsers += $M }}}



# disable on Exchange OWA APP level

$insights = get-app -organizationapp | where { $_.Displayname -match 'insights'}
$insights | fl displayname,description,defaultstateforuser,enabled,appid
$insights | % { set-app -organizationapp $_.Appid -Enabled $false }
$insights | % { set-app -organizationapp $_.Appid -DefaultStateForUser 'Disabled' }