$admin_email = $args[0];

if(-Not Get-Module -ListAvailable -Name ExchangeOnlineManagement){
  Install-Module -Name ExchangeOnlineManagement -Scope CurrentUser
}

Import-Module ExchangeOnlineManagement

Connect-ExchangeOnline -UserPrincipalName $admin_email

SetTransportConfig -SmtpClientAuthenticationDisabled $true
