---
toc: ~admin~ Managing the Game
summary: Marque Commands for managing characters of rank Adept.
---
# Marque Management
The journey from novice to fully marqued courtesan is documented in the rank and marque progress of a character. Beside the monthly automated progress that is handled via a cron job, there are a number of commands available.

Players with the permission "manage_marques" will also have a "House Management" tab in their profile, which allows them to trigger the commands from there.

## Changing the Value of the Marque (admin only)
`marque/raise <name>=<percent>` - Adds progress to the marque (as in the monthly off camera marque raise).

## Managing Marques (permission manage_marques)
`marque/list` - Lists characters with marques in progress.
`marque/init <name>` - Sets the marque to a starting value of zero (which happens usually after the debut), and also changes the rank from novice to adept. This goes along with a story achievement award (debuted).
`marque/acknowledge <name>` - Removes the marque attribute and sets the rank from adept to courtesan (the usual things that happen after a marque is acknowledged). This goes along with a story achievement award (acknowledged).
