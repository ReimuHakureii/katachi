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

function Import-UtilisateursCSV {
    param(
        [Parameter(Mandatory=$true)]
        [string]$CheminCSV
    )

    # Est-ce que CSV existe?
    if (-not (Test-Path $CheminCSV)) {
        Write-Log -Message "Fichier CSV introuvable : $CheminCSV" -Niveau "Error"
        return
    }

    $utilisateurs = Import-Csv -Path $CheminCSV

    foreach ($user in $utilisateurs) {
        $username = $user.Username
        $nomComplet = "$($user.Prenom) $($user.Nom)"
        $groupe   = $user.Groupe

        # Est-ce que utilisateur existe?
        $existeDeja = $null
        try {
            $existeDeja = Get-LocalUser -Name $username -ErrorAction Stop
        }
        catch {
            $existeDeja = $null
        }

        if ($existeDeja) {
            Write-Log -Message "L'utilisateur '$username' existe déjà. Ignoré." -Niveau "Warning"
        }
        else {
            try {
                # mdp gen 1ere connexion
                $motDePasse = ConvertTo-SecureString "Changez-Moi123!" -AsPlainText -Force

                New-LocalUser `
                    -Name        $username `
                    -Password    $motDePasse `
                    -FullName    $nomComplet `
                    -Description "Importé depuis CSV" `
                    -ErrorAction Stop | Out-Null

                Write-Log -Message "Utilisateur '$username' ($nomComplet) créé avec succès." -Niveau "Info"

                # Groupe
                try {
                    Add-LocalGroupMember -Group $groupe -Member $username -ErrorAction Stop
                    Write-Log -Message "Utilisateur '$username' ajouté au groupe '$groupe'." -Niveau "Info"
                }
                catch {
                    Write-Log -Message "Erreur lors de l'ajout au groupe '$groupe' pour '$username' : $($_.Exception.Message)" -Niveau "Error"
                }
            }
            catch {
                Write-Log -Message "Erreur lors de la création de '$username' : $($_.Exception.Message)" -Niveau "Error"
            }
        }
    }

    Write-Log -Message "Importation des utilisateurs terminée." -Niveau "Info"
}

# Test fichier CSV
$csvTest = "C:\Temp\users.csv"
@"
Nom,Prenom,Username,Groupe
Dupont,Jean,jdupont,Utilisateurs
Martin,Sophie,smartin,Administrateurs
Leclerc,Pierre,pleclerc,Utilisateurs
"@ | Out-File -FilePath $csvTest -Encoding UTF8

Write-Host "Fichier CSV de test créé : $csvTest"

# Importation
Import-UtilisateursCSV -CheminCSV $csvTest