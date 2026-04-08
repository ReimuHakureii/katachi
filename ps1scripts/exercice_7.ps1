function Test-AlerteEspaceDisque {
    param([double]$SeuilGB)

    $volumes = Get-Volume

    foreach ($volume in $volumes) {
        $libreGB = [math]::Round($volume.SizeRemaining / 1GB, 2)
        
        if ($libreGB -lt $SeuilGB) {
            Write-Host "[ALERTE] $($volume.DriveLetter): faible espace" -ForegroundColor Red
        }
    }
}

Test-AlerteEspaceDisque -SeuilGB 50