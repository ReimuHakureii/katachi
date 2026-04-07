function Start-Calculatrice {
    $continuer = $true

    while ($continuer) {
        Write-Host "`n--- Menu Calculatrice ---"
        Write-Host "1. Additionner deux nombres"
        Write-Host "2. Soustraire deux nombres"
        Write-Host "3. Multiplier deux nombres"
        Write-Host "4. Diviser deux nombres"
        Write-Host "5. Quitter"

        $choix = Read-Host "Votre choix (1-5)"

        if ($choix -eq "5") {
            Write-Host "Au revoir !" -ForegroundColor Green
            $continuer = $false
        }
        elseif ($choix -in "1","2","3","4") {
            [double]$a = Read-Host "Entrez le premier nombre"
            [double]$b = Read-Host "Entrez le deuxième nombre"

            switch ($choix) {
                "1" {
                    $resultat = $a + $b
                    Write-Host "Résultat : $a + $b = $resultat" -ForegroundColor Green
                }
                "2" {
                    $resultat = $a - $b
                    Write-Host "Résultat : $a - $b = $resultat" -ForegroundColor Green
                }
                "3" {
                    $resultat = $a * $b
                    Write-Host "Résultat : $a * $b = $resultat" -ForegroundColor Green
                }
                "4" {
                    if ($b -eq 0) {
                        Write-Host "Erreur : Division par zéro impossible." -ForegroundColor Red
                    }
                    else {
                        $resultat = $a / $b
                        Write-Host "Résultat : $a / $b = $resultat" -ForegroundColor Green
                    }
                }
            }
        }
        else {
            Write-Host "Choix invalide. Veuillez entrer un nombre entre 1 et 5." -ForegroundColor Yellow
        }
    }
}