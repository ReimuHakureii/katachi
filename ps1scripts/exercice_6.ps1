function Get-InventaireDisques {
    $disques = Get-Disk

    foreach ($disque in $disques) {
        Write-Host "Disque $($disque.Number)"
    }
}

Get-InventaireDisques