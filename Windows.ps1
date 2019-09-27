function Start-IIS {
    iisreset.exe $env:COMPUTERNAME /start
}
function Stop-IIS {
    iisreset.exe $env:COMPUTERNAME /stop
}
function Reset-IIS {
    iisreset.exe $env:COMPUTERNAME
}
function Close-All {
    (Get-Process | ?{ $_.MainWindowTitle -ne "" -and $_.ProcessName -ne "powershell" }) | Stop-Process
}

function Install-IIS {
    Test-Administrator

    $required = @(
        'IIS-WebServerRole',
        'IIS-WebServer',
        'IIS-CommonHttpFeatures',
        'IIS-HttpErrors',
        'IIS-HttpRedirect',
        'IIS-ApplicationDevelopment',
        'IIS-NetFxExtensibility45',
        'IIS-HealthAndDiagnostic',
        'IIS-HttpLogging',
        'IIS-HttpTracing',
        'IIS-Security',
        'IIS-URLAuthorization',
        'IIS-RequestFiltering',
        'IIS-IPSecurity',
        'IIS-Performance',
        'IIS-WebServerManagementTools',
        'IIS-ManagementScriptingTools',
        'WCF-Services45',
        'WCF-TCP-PortSharing45',
        'IIS-StaticContent',
        'IIS-DefaultDocument',
        'IIS-DirectoryBrowsing',
        'IIS-WebSockets',
        'IIS-ApplicationInit',
        'IIS-ASPNET45',
        'IIS-ISAPIExtension',
        'IIS-ISAPIFilter',
        'IIS-BasicAuthentication',
        'IIS-HttpCompressionStatic',
        'IIS-ManagementConsole',
        'IIS-WindowsAuthentication',
        'IIS-DigestAuthentication',
        'NetFx4-AdvSrvs',
        'NetFx4Extended-ASPNET45',
        'Microsoft-Windows-NetFx4-US-OC-Package',
        'Microsoft-Windows-NetFx4-WCF-US-OC-Package'
    )
    $enabled = Get-WindowsOptionalFeature -Online | Where-Object {$_.State -eq 'Enabled'} | Select-Object -ExpandProperty FeatureName
    $missing = $required | Where-Object { $enabled -notcontains $_ }
    foreach ($feature in $missing) {
        Enable-WindowsOptionalFeature -Online -FeatureName $feature -All
    }
}

function Test-Administrator {
    $isAdministrator = (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
    if (!($isAdministrator)) {
        throw 'This script has to be run as an Administrator'
    }
}