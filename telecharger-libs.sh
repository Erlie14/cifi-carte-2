#!/usr/bin/env bash
# Télécharge les bibliothèques Leaflet dans le dossier "lib" (à exécuter une seule fois, avec accès Internet).
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p lib/images
L="https://unpkg.com/leaflet@1.9.4/dist"
C="https://unpkg.com/leaflet.markercluster@1.5.3/dist"
for f in leaflet.css leaflet.js images/layers.png images/layers-2x.png images/marker-icon.png images/marker-icon-2x.png images/marker-shadow.png; do
  echo "Téléchargement de $f..."; curl -fsSL "$L/$f" -o "lib/$f"
done
for f in MarkerCluster.css MarkerCluster.Default.css leaflet.markercluster.js; do
  echo "Téléchargement de $f..."; curl -fsSL "$C/$f" -o "lib/$f"
done
echo "Terminé : le dossier lib est prêt."
