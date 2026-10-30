# CIFI – Widget carte pour Grist numérique

Widget personnalisé (Leaflet) qui affiche sur une carte les établissements d'une table Grist, colorés selon leur niveau de risque, avec des fiches pliables. La carte se met à jour automatiquement quand la table change.

Le dossier ne contient **aucune donnée** : uniquement des fichiers statiques (HTML, JavaScript, CSS). Les données restent dans Grist.

---

## Partie 1 – Pour la personne qui publie (service informatique)

### Contenu du dossier
```
cifi-carte/
├── index.html               ← le widget
├── lib/                     ← bibliothèques Leaflet (à remplir, étape 1)
├── telecharger-libs.ps1     ← script Windows
├── telecharger-libs.sh      ← script Linux / Mac
└── LISEZMOI.md
```

### Étape 1 – Remplir le dossier `lib` (une seule fois)
Sur un poste avec accès Internet :
- **Windows** : clic droit sur `telecharger-libs.ps1` > « Exécuter avec PowerShell ».
- **Linux / Mac** : `./telecharger-libs.sh`

Le script télécharge Leaflet 1.9.4 et Leaflet.markercluster 1.5.3 depuis unpkg.com. Après exécution, `lib/` contient 3 fichiers CSS, 2 fichiers JS et un sous-dossier `images/` (5 images).
Si le poste n'a pas Internet, récupérez ces mêmes fichiers ailleurs et copiez-les à la main dans `lib/` avec les mêmes noms.

### Étape 2 – Publier le dossier en HTTPS
Déposez tout le dossier `cifi-carte` sur un espace qui sert des pages web statiques (serveur interne, forge avec pages web, GitHub Pages…). Notez l'adresse finale, par exemple :
`https://votre-espace.exemple.fr/cifi-carte/index.html`

### Points de vigilance
- **HTTPS obligatoire.**
- **Affichage dans un cadre autorisé** : Grist affiche le widget dans un iframe. Le serveur ne doit pas envoyer `X-Frame-Options: DENY`, ni une directive CSP `frame-ancestors` qui exclurait `https://grist.numerique.gouv.fr`.
- **Accès sans authentification** depuis le navigateur des utilisateurs (le widget est chargé par leur navigateur).
- **Fonds de carte** : les utilisateurs doivent pouvoir joindre `https://data.geopf.fr` (Géoplateforme IGN). Pour une étanchéité totale, remplacez les adresses dans la section « Fonds de carte » de `index.html` par vos propres tuiles.
- **Adresse de Grist** : `index.html` charge `https://grist.numerique.gouv.fr/grist-plugin-api.js`. Si une autre instance est utilisée, modifiez cette ligne.

### Mise à jour
Pour modifier le widget, remplacez simplement `index.html` sur le serveur. Les utilisateurs verront la nouvelle version en rechargeant la page Grist (Ctrl+F5 si besoin).

---

## Partie 2 – Pour l'utilisatrice (dans Grist)

1. Ouvrez votre document, puis **Ajouter nouveau > Ajouter un widget à la page**.
2. Dans « Sélectionner le widget », choisissez **Personnalisé**, puis la table qui contient vos établissements.
3. Cliquez sur les trois points du widget > **Options du widget**. Dans « Entrer l'URL personnalisée », collez l'adresse du widget, puis validez.
4. Choisissez le niveau d'accès **« Lire la table »** (le widget ne demande rien de plus).
5. Dans le panneau de droite, associez les colonnes :
   - **Nom de l'établissement** (obligatoire)
   - **Latitude** et **Longitude** (obligatoires, colonnes numériques)
   - **Niveau de risque** (facultatif ; texte du type Faible / Moyen / Élevé / Critique)
6. Toutes les autres colonnes apparaissent automatiquement dans la fiche pliable.

### Astuces
- Pour relier la carte à une fiche détaillée : sur le widget carte, utilisez « Sélectionner par » avec l'autre widget. Un clic sur un point sélectionne alors la ligne correspondante.
- Pour cacher des colonnes dans la fiche : modifiez la ligne `COLONNES_MASQUEES` en haut du script de `index.html`.
- Les points sans latitude/longitude valides ne s'affichent pas ; leur nombre est indiqué en haut à gauche.

### En cas de problème
| Constat | Cause probable |
|---|---|
| Le widget reste blanc | L'adresse est incorrecte, ou le dossier `lib` est vide ou mal publié |
| Message « Associez les colonnes » | Les colonnes nom, latitude, longitude ne sont pas encore choisies |
| Fond de carte gris | `data.geopf.fr` est bloqué sur le réseau |
| Aucun point | Latitude et longitude vides, ou inversées, ou au mauvais format (texte avec virgule) |
| Marqueurs gris avec « ? » | Valeur de niveau non reconnue : voir la liste `MOTS` dans `index.html` |
