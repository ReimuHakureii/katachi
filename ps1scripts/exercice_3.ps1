function Write-Log {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message,

        [ValidateSet("Info", "Warning", "Error")]
        [string]$Niveau = "Info"
    )

    $horodatage = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $ligneLog = "[$horodatage] [$Niveau] $Message"
    $cheminLog = "C:\Temp\script.log"

    if (-not (Test-Path "C:\Temp")) {
        New-Item -ItemType Directory -Path "C:\Temp" | Out-Null
    }

    $ligneLog | Out-File -FilePath $cheminLog -Append -Encoding UTF8
    
    switch ($Niveau) {
        "Info" { Write-Host $ligneLog -ForegroundColor Cyan }
        "Warning" { Write-Host $ligneLog -ForegroundColor Yellow }
        "Error" { Write-Host $ligneLog -ForegroundColor Red }
    }
}

Write-Log -Message "Démarrage du script" -Niveau "Info"
Write-Log -Message "Espace Disque faible détecté" -Niveau "Warning"
Write-Log -Message "Impossible de contacter le serveur" -Niveau "Error"