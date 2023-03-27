## Exigences
* Base de données MySQL
* quelques connaissances en LUA
* ES_EXTENDED

## Comment utiliser
Lorsque vous conduisez, après un certain temps, vous acquerrez des compétences de conduite.
Appuyez sur le bouton "Page Down" pour ouvrir le menu. Si vous le souhaitez, vous pouvez modifier le bouton en allant dans client.lua et modifier la variable : "openKey".

## Installation
N'oubliez pas que toutes les fonctions "TriggerServerEvent" sont côté client.
1. Add "TriggerServerEvent('Kskills:addStamina', GetPlayerServerId(PlayerId()), (math.random() + 0))" à esx_gym où vous voulez que les gens gagnent en endurance.
2. Add "TriggerServerEvent('Kskills:addStrength', GetPlayerServerId(PlayerId()), (math.random() + 0))" à esx_gym où vous voulez que les gens gagnent en force.
3. Add "TriggerServerEvent('Kskills:addFishing', GetPlayerServerId(PlayerId()), (math.random() + 0))" à votre mod de pêche préféré.
4. Add "TriggerServerEvent('Kskills:addDrugs', GetPlayerServerId(PlayerId()), (math.random() + 0))" à esx_drugs où vous voulez que les gens acquièrent des compétences en matière de drogue.


