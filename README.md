Jours fériés au Québec 📆
================================================================================

Voici un fichier prêt à l'emploit des jours fériés au Québec de 1980 à 2022. Les jours fériés qui tombaient la fin de semaine ont été reportés respectivement au lundi suivant ou au vendredi précédent. Le but de ce fichier est donc de reproduire les congés réels des gens, à des fins d'analyse des demandes de soins de santé.

Le fichier est storé dans `out/quebec_holidays_version.csv`.

Voici les colonnes du fichier : 

| Colonne            | Description                                                     |
|--------------------|-----------------------------------------------------------------|
| `DATE`             | Date dans le format `YYYYMMDD`                                  |
| `YEAR`             | Année en format `YYYY`                                          |
| `MONTH`            | Mois en format `MM`                                             |
| `DAY`              | Jour du mois en format `DD`                                     |
| `WEEKDAY`          | Jour de la semaine de `1` (lundi) à `7` (dimanche)              |
| `WEEKDAY_CHR`      | Abréviation de trois lettres du jour de la semaine (en anglais) |
| `WEEKEND`          | Indicateur `1`/`0`de fin de semaine                             |
| `HOLIDAY`          | Indicateur `1`/`0` d'un jour férié                              |
| `HOLIDAY_CHR`      | Nom du jour férié                                               |
| `HOLIDAY_WE`       | Indicateur `1`/`0` d'une fin de semaine ou d'un jour férié      |

*Enjoy !* 

---

**Améliorations possible :** 

+ Revoir l'attribution des jours fériés pour Noël, le Jour de l'An, la Saint-Jean-Bapstiste et le Jour du Canada. Ceux-ci sont attribués d'une manière plus "officielle" (i.e. le jour suivant ou précédent un week-end), mais le comportement "habituel" pourrait être différent (i.e. une préférence pour les congés avant l'événement).
