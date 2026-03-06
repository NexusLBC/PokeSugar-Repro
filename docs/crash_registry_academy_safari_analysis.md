# Résumé

Le crash client `Registry remapping failed` sur `academy:safari_ticket_base` est **reproduit au moment de la sync des registres/modèles**, mais l’analyse du repo montre qu’il n’y a **pas** de double jar `academy`/`safari` ni de double `mod id` Fabric côté serveur.

Constats principaux :

- Un seul jar `academy` est présent : `mods/academy-mc1.21.1-v2.2.0+build.532-fabric.jar`.
- Un seul jar `safari` est présent : `mods/safari-dimension-0.0.11.jar`.
- Aucun doublon exact d’archive (`sha1`) parmi les 192 archives (`.jar`/`.zip`) scannées.
- Aucun `mod_id` en double parmi les jars inspectés.
- Le namespace `academy` côté assets/data de jars n’apparaît que dans le jar `academy`.
- La chaîne exacte `academy:safari_ticket_base` / `safari_ticket_base` n’apparaît dans aucun fichier texte ni ressource statique du repo/jars (elle semble construite dynamiquement).

La piste la plus probable est donc un **doublon de mapping modèle généré à runtime** (ou double chargement logique d’un même modèle) plutôt qu’un simple doublon de fichiers jar.

---

# Fichiers et dossiers scannés

## Méthode (commandes exécutées)

- Cartographie des scripts/points d’entrée :
  - `find . -type f \( -iname '*.sh' -o -iname '*.bat' -o -iname '*.ps1' -o -iname 'docker-compose*.yml' -o -iname 'docker-compose*.yaml' -o -iname 'Dockerfile*' -o -iname '*.service' -o -iname '*.env' \) | sort`
  - `find . -type l -print | sort`
- Inventaire complet archives + hash : script Python (sortie CSV)
- Recherche texte : `rg -n -uuu -a --no-ignore 'academy:safari_ticket_base|safari_ticket_base' .`
- Inspection jars : `unzip -l`, `unzip -p`, parsing `fabric.mod.json`.

## Emplacements potentiellement chargés par le serveur

### Confirmés comme chargés/consommés

- `mods/` : jars Fabric serveurs.
- `config/` : configurations mods, dont `config/academy/*.json`.
- `datapacks/` : chargé explicitement (voir `global_packs.toml`) et activé aussi via `server.properties` packs initiaux.
- `world/` : monde serveur (`level-name=world`), `world/serverconfig`, données runtime safari.
- `libraries/` : dépendances Java (pas des mods Fabric, mais classpath runtime).

### Indices de chargement multi-sources (packs)

- `config/global_packs.toml` :
  - resourcepacks requis : `global_packs/required_resources/`, `datapacks/`
  - datapacks requis : `datapacks/`, `global_packs/required_data/`
- `config/resourcepackoverrides.json` : pack par défaut `file/Academy`, `file/CCC_1.9.2`, `file/Journey Mounts`, etc.
- `server.properties` : `initial-enabled-packs` contient notamment `academy`, `safari`, `cobblemon...`.

### Non trouvés

- Aucun script shell/bat/ps1, aucun `docker-compose`, `Dockerfile`, service systemd, ni symlink.
- Aucun argument explicite `--gameDir`/`--mods` dans scripts (car scripts absents dans ce repo).

---

# Inventaire complet des jars/zip

Inventaire exhaustif généré dans :

- `docs/crash_registry_academy_safari_archives.csv`

Colonnes : `path, filename, size_bytes, mtime_iso, sha1`.

Résumé :

- Total archives scannées (`jar` + `zip`) : **192**.
- Jars nommés `academy` : **1**
  - `mods/academy-mc1.21.1-v2.2.0+build.532-fabric.jar`
- Jars nommés `safari` : **1**
  - `mods/safari-dimension-0.0.11.jar`
- Doublons exacts (même hash SHA1) : **0 groupe**.
- Doublons “même mod, version différente” détectables par nom : **aucun cas academy/safari**.

---

# Résultats grep texte

## Recherche `academy:safari_ticket_base` et `safari_ticket_base`

Commande :

- `rg -n -uuu -a --no-ignore 'academy:safari_ticket_base|safari_ticket_base' .`

Résultat :

- **Aucune occurrence utile** dans les sources/configs/jars extractibles.
- La seule “occurrence” est le nom de colonne d’un CSV généré pendant l’audit.

## Recherche `safari_ticket` / `academy`

Occurrences utiles trouvées :

- `config/academy/safari.json`
  - tickets `base`, `great`, `golden`
  - modèles :
    - `academy:safari_ticket/base#inventory`
    - `academy:safari_ticket/great#inventory`
    - `academy:safari_ticket/golden#inventory`
- `datapacks/Academy/data/academy/loot_table/academy/safari_ticket.json`
  - loot sur `academy:safari_ticket` avec composant `academy:safari_ticket_entry` (`base|great|golden`).

Conclusion grep :

- Le suffixe `_base` du crash **n’est pas stocké tel quel** ; il est probablement dérivé/normalisé à runtime à partir de `safari_ticket` + entrée `base`.

---

# Résultats inspection jars

## Jars suspects ciblés

### 1) `mods/academy-mc1.21.1-v2.2.0+build.532-fabric.jar`

`fabric.mod.json` :

- `id`: `academy`
- `version`: `2.2.0`
- nested jars :
  - `META-INF/jars/animated-gif-lib-1.4.jar`
  - `META-INF/jars/mixinsquared-fabric-0.3.3.jar`

Ressources safari côté academy :

- `assets/academy/models/item/safari_ticket.json`
- `assets/academy/models/item/safari_ticket/base.json`
- `assets/academy/models/item/safari_ticket/great.json`
- `assets/academy/models/item/safari_ticket/golden.json`
- `assets/academy/textures/item/safari_ticket/*.png`
- `assets/academy/lang/*.json` (clé `item.academy.safari_ticket`)

### 2) `mods/safari-dimension-0.0.11.jar`

`fabric.mod.json` :

- `id`: `safari`
- `version`: `0.0.11`

Ressources item côté safari :

- namespace `assets/safari/...`
- items `ticket_5`, `ticket_15`, `ticket_30` etc.
- **pas** de `assets/academy/...`
- **pas** de `safari_ticket_base`

### 3) `mods/cobblemon_knowlogy-fabric-1.5.0-1.21.1.jar`

- contient `fabric.mod.json` + `META-INF/mods.toml`.
- contient une doc `.../safari_ball.md`, sans namespace `academy` de modèles/items.

## Vérification META-INF / fabric/quilt

- `fabric.mod.json` présent et valide sur `academy` et `safari`.
- pas de `quilt.mod.json` pertinent pour ce crash.
- `META-INF/MANIFEST.MF` lisible sur les deux jars ciblés.

---

# Détection des doublons

Table de corrélation générée dans :

- `docs/crash_registry_academy_safari_mod_metadata.csv`

Colonnes :

- `jar_path`, `metadata`, `mod_id`, `version`, `name`,
- `has_assets_academy`, `has_data_academy`, `has_safari_ticket_base`.

Résultat clé :

- `mod_id` dupliqué : **0**.
- jar contenant `assets/academy` ou `data/academy` : **1 seul** (`academy` jar).
- jar contenant `safari_ticket_base` en statique : **0**.

---

# Analyse de academy:safari_ticket_base

## Où `academy:safari_ticket_base` est défini ?

- Introuvable tel quel dans les fichiers statiques (repo + jars).
- Les éléments source les plus proches sont :
  - modèle `academy:safari_ticket/base#inventory` (`config/academy/safari.json`)
  - composant loot `academy:safari_ticket_entry=base` (datapack Academy).

Interprétation :

- `academy:safari_ticket_base` semble être un **identifiant modèle dérivé** en phase runtime (génération/normalisation des IDs d’item model variants).

## Est-il défini plusieurs fois ?

- Pas de preuve de double définition statique directe (fichiers/jars).
- Le conflit indique plutôt une **double insertion runtime de la même clé** dans `ItemModels.modelIds`.

## Plusieurs jars/mods exposent academy/safari ?

- `academy` namespace assets/data côté jar : seulement `academy` mod.
- `safari` namespace assets côté jar : `safari-dimension`.
- Pas de second jar academy/safari dans le repo.

## Plusieurs dossiers de mods utilisés ?

- Un seul dossier `./mods` pour Minecraft côté repo.
- `showdown/data/mods` existe mais concerne l’outil Showdown (pas Fabric).

## Ancien jar / jar embarqué chargé ?

- Aucun vieux jar academy/safari détecté hors `mods/`.
- Jars embarqués dans academy : `animated-gif-lib` + `mixinsquared` uniquement (pas de contenu academy/safari supplémentaire).

---

# Hypothèse principale

## Cause n°1 (confiance élevée)

**Duplication runtime du mapping de modèle academy safari ticket (génération interne), sans doublon de fichiers externes.**

Preuves :

1. `academy:safari_ticket_base` introuvable en statique.
2. Absence de doublons jars/mod_id/namespace `academy` externes.
3. Existence d’un système de variantes (`base/great/golden`) + modèles safari_ticket dans academy.

## Cause n°2 (confiance moyenne)

**Double chargement logique de packs (builtin + fichiers) entraînant double registration d’assets côté client.**

Preuves :

1. `initial-enabled-packs` inclut `academy` et `safari`.
2. `global_packs.toml` impose des chemins packs globaux (`datapacks/`, etc.).
3. `resourcepackoverrides.json` active des `file/*` packs dont `file/Academy`.

Limite : aucune preuve directe que `file/Academy` redéfinit `safari_ticket_base` (pas trouvé en statique).

## Cause n°3 (confiance faible)

**Conflit direct academy vs safari-dimension sur même item model ID.**

Pourquoi faible :

- `safari-dimension` utilise le namespace `safari`, pas `academy`, et ne contient pas `safari_ticket_base`.

---

# Chemins suspects à supprimer ou vérifier ensuite

1. `mods/academy-mc1.21.1-v2.2.0+build.532-fabric.jar`
2. `config/academy/safari.json`
3. `datapacks/Academy/data/academy/loot_table/academy/safari_ticket.json`
4. `config/global_packs.toml`
5. `config/resourcepackoverrides.json`
6. `server.properties` (clé `initial-enabled-packs`)
7. `resourcepacks/Academy/` (pack forcé `file/Academy`)

---

# Jars suspects à comparer

- `mods/academy-mc1.21.1-v2.2.0+build.532-fabric.jar`
- `mods/safari-dimension-0.0.11.jar`
- nested jars dans academy :
  - `META-INF/jars/animated-gif-lib-1.4.jar`
  - `META-INF/jars/mixinsquared-fabric-0.3.3.jar`

---

# Prochaine action recommandée

Sans “corriger” ici (analyse only), la prochaine étape d’investigation doit être instrumentée côté logs runtime client/serveur pour confirmer la double insertion :

1. Démarrer avec logs debug Fabric resource/model loading.
2. Capturer l’ordre exact de chargement des resource packs (`academy`, `file/Academy`, autres).
3. Vérifier si `academy` enregistre deux fois le variant `base` du safari ticket (reload listener, init client + reload).

---

# Garde-fou automatique

Exemple de script de contrôle à exécuter en CI avant déploiement :

```bash
python - <<'PY'
import os, zipfile, json, collections
mods=[]
for f in sorted(os.listdir('mods')):
    if not f.endswith('.jar'): continue
    p=os.path.join('mods',f)
    z=zipfile.ZipFile(p)
    if 'fabric.mod.json' in z.namelist():
        j=json.loads(z.read('fabric.mod.json'))
        mods.append((f,j.get('id'),j.get('version')))
by=collections.defaultdict(list)
for f,mid,ver in mods:
    by[mid].append((f,ver))
for mid,arr in sorted(by.items()):
    if mid and len(arr)>1:
        print('DUPLICATE_MOD_ID',mid,arr)
PY
```

Et contrôle namespace `academy` dans jars :

```bash
find mods -type f -name '*.jar' -print0 | while IFS= read -r -d '' f; do
  if unzip -Z1 "$f" | rg -qi '^assets/academy/|^data/academy/'; then
    echo "academy-namespace: $f"
  fi
done
```

