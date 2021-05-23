<#
  This powershell script will turn SMTP ON for your Office365 account, globally.
  Useful for allowing applications using tech such as Nodemailer to send emails to your account
  
  Takes in the admin email address as an argument.
  Will download The ExchangeOnlineManagement module required if not already downloaded.
  Best used on a machine running Windows, and make sure that you run:
    Set-ExecutionPolicy RemoteSigned
  from Admin Powershell
#>

$admin_email = $args[0]
$sets_SMTP = $args[1]
$email_validator = '/^\S+@\S+\.\S+$/'

if(-Not (admin_email -match $email_validator)){
  throw "First argument is not a valid email"
}

if($sets_SMTP -ne "true" -Or $sets_SMTP -ne "false"){
  throw "Second argument is invalid. Can only accept 'true' or 'false'"
}

if(-Not (Get-Module -ListAvailable -Name ExchangeOnlineManagement)){
  Install-Module -Name ExchangeOnlineManagement -Scope CurrentUser
}

Import-Module ExchangeOnlineManagement

Connect-ExchangeOnline -UserPrincipalName $admin_email

SetTransportConfig -SmtpClientAuthenticationDisabled $sets_SMTP
