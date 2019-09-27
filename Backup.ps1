function Get-ChocolateyPackages {
    Write-Output "<packages>"
    choco list -lo -r -y | ForEach-Object {
        $p = $_.Split('|')
        "   <package id=`"$($p[0])`" version=`"$($p[1])`" />"
    }
    Write-Output "</packages>"
}
function Backup-ChocolateyPackages {
    param (
        [Parameter(Mandatory=$false, ValueFromPipeline=$true)]
        [string]
        $Path
    )

    if ([string]::IsNullOrEmpty($Path)) {
        $filename = (Get-Date -Format "yyyy-MM-dd") + "_" + "backup.config"
        $Path = [System.IO.Path]::Combine($env:OneDriveCommercial, "Backup", "Chocolatey")

        if (!(Test-Path $Path)) {
            New-Item -ItemType Directory -Force -Path $Path | Out-Null
        }
        else {
            Write-Output "Path was not provide and cannot find one drive default path"
        }
        $Path = [System.IO.Path]::Combine($Path, $filename)
    }

    Get-ChocolateyPackages | Out-File -FilePath $Path -Encoding utf8
}