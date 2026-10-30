# Télécharge les bibliothèques Leaflet dans le dossier "lib" (à exécuter une seule fois, avec accès Internet).
# Clic droit > "Exécuter avec PowerShell", ou : powershell -ExecutionPolicy Bypass -File telecharger-libs.ps1
$ErrorActionPreference = "Stop"
# Fonctionne en exécutant le fichier OU en collant le texte dans PowerShell (dans ce cas, le dossier courant est utilisé).
$racine = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }
$lib = Join-Path $racine "lib"
New-Item -ItemType Directory -Force (Join-Path $lib "images") | Out-Null

$leaflet = "https://unpkg.com/leaflet@1.9.4/dist"
$cluster = "https://unpkg.com/leaflet.markercluster@1.5.3/dist"
$fichiers = @(
  @("$leaflet/leaflet.css", "leaflet.css"),
  @("$leaflet/leaflet.js", "leaflet.js"),
  @("$leaflet/images/layers.png", "images\layers.png"),
  @("$leaflet/images/layers-2x.png", "images\layers-2x.png"),
  @("$leaflet/images/marker-icon.png", "images\marker-icon.png"),
  @("$leaflet/images/marker-icon-2x.png", "images\marker-icon-2x.png"),
  @("$leaflet/images/marker-shadow.png", "images\marker-shadow.png"),
  @("$cluster/MarkerCluster.css", "MarkerCluster.css"),
  @("$cluster/MarkerCluster.Default.css", "MarkerCluster.Default.css"),
  @("$cluster/leaflet.markercluster.js", "leaflet.markercluster.js")
)
foreach ($f in $fichiers) {
  Write-Host "Téléchargement de $($f[1])..."
  Invoke-WebRequest -Uri $f[0] -OutFile (Join-Path $lib $f[1])
}
Write-Host "Terminé : le dossier lib est prêt."
