Import-Module ActiveDirectory
$file = "C:\Users\administrator.CONTOSO\Documents\Visual Studio 2010\Projects\PerfTestHarness\SupportGroups200.txt"
$SupportGroups = Get-Content $file

foreach($SupportGroupName in $SupportGroups)
{
    $ss = ConvertTo-SecureString -AsPlainText -Force -String SMX#2001
    $UserName = $SupportGroupName + "User"
    $User = New-ADUser -Name $UserName -CannotChangePassword $true -ChangePasswordAtLogon $false -DisplayName $UserName -Enabled $true -PassThru -PasswordNeverExpires $true -SamAccountName $UserName -AccountPassword $ss
    $Group = New-ADGroup -Name $SupportGroupName -SamAccountName $SupportGroupName -DisplayName $SupportGroupName -GroupCategory Security -GroupScope Global -PassThru
    Add-ADGroupMember -Identity $Group -Members $User
}