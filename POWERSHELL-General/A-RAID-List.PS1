
$All = [System.Collections.ArrayList]@()
$GUIDs = [System.Collections.ArrayList]@()
$Userprincipalnames = [System.Collections.ArrayList]@()
$Distinguishednames = [System.Collections.ArrayList]@()
$PrimarySMTPAddresses = [System.Collections.ArrayList]@()
$ExchangeGUIDs = [System.Collections.ArrayList]@()


$MBXs = get-EXOmailbox -ResultSize unlimited

for ($M = 0; $M -lt $MBXs.count; $M++) { 

               $GUIDs.Add($MBXs[$M].GUID)
  $Userprincipalnames.Add($MBXs[$M].Userprincipalname)
  $Distinguishednames.Add($MBXs[$M].Distinguishedname)
$PrimarySMTPAddresses.Add($MBXs[$M].PrimarySMTPAddress)
       $ExchangeGUIDs.Add($MBXs[$M].ExchangeGUID)
 }


for ($M = 0; $M -lt $MBXs.count; $M++) { 

               $GUIDs[$M]
  $Userprincipalnames[$M]
  $Distinguishednames[$M]
$PrimarySMTPAddresses[$M]
       $ExchangeGUIDs[$M]
 }


[System.Collections.ArrayList]$MBX = $mbxs.userprincipalname

$label="[$($param.Language) $($culture.DisplayName)] Time[$($param.TimeFormat)] Date[$($param.DateFormat)]"

$S =" [MBX] ($($M+1)/$count)  [Time]"
$A = "Changing Folder language $label  [Mailbox Count] ($($M+1)/$count) [Mailbox] $($MBX[$M])"
Write-Progress -Activity $A -Status $S -PercentComplete (($M/$count)*100) -SecondsRemaining ($count-$M) ;

Measure-Command {

for ($M = 0; $M -lt $MBXs.count; $M++) { 

               $GUIDs[$M]
  $Userprincipalnames[$M]
  $Distinguishednames[$M]
$PrimarySMTPAddresses[$M]
       $ExchangeGUIDs[$M]
 } }


[System.Collections.ArrayList]$MBX = $MBXs | select GUID,Userprincipalname,Distinguishedname,PrimarySMTPAddress,ExchangeGUID

 Measure-Command {

for ($M = 0; $M -lt $MBXs.count; $M++) { 

   $($MBX[$M].GUID)
   $($MBX[$M].Userprincipalname)
   $($MBX[$M].Distinguishedname)
   $($MBX[$M].PrimarySMTPAddress)
   $($MBX[$M].ExchangeGUID)
 } }
 $MBXs.GetType()
 $GUIDs.GetType()

  Measure-Command {

for ($M = 0; $M -lt $MBXs.count; $M++) { 

   $($MBXs[$M].GUID)
   $($MBXs[$M].Userprincipalname)
   $($MBXs[$M].Distinguishedname)
   $($MBXs[$M].PrimarySMTPAddress)
   $($MBXs[$M].ExchangeGUID)
 } }