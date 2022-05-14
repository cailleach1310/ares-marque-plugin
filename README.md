# Ares Marque Plugin
A plugin for handling marque stuff on games of Kushiel theme. 

## Credits
Lyanna@AresCentral

## Overview
Anyone familiar with the books or games of Kushiel theme will know that the marque is an aspect that only affects courtesan concepts, and more particularly, only novices and adepts. In fact the marque does not necessarily require code at all - it could be handled simply on basis of +requests, with the player declaring at some point they are starting or have completed the marque. Still, I've seen this being handled on code basis on mushes of the theme, and so I've been working on this as some sort of coding project to learn AresMUSH. Now I'm putting it out there for anyone who'd like to use it. If you want some code-side marque support in your Kushiel-based game, go ahead, use it as is or adapt it to your needs.

The marque plugin requires only adjustments in the custom AresMUSH files, so it shouldn't affect future merges and version upgrades. I've developed and tested this with v0.106 - v0.108.

### What this plugin covers
* Chargen: Setting marque during chargen.
* Profile: Making the marque part of the profile.
* Staff-side marque management commands from within the game.
* Staff-side marque management route from the webportal.
* Awarding achievements when completing phases of novice and adept.
* Cron job based monthly marque progress for off camera assignations.
* Additional raises can be applied by staff when appliccable.

### Screenshots
In game view of the 'marque/list' command:
![Client](https://github.com/cailleach1310/ares-marque-plugin/blob/master/images/marque_list_command.PNG)

Webportal view of the marque management route:
![Web-Portal](https://github.com/cailleach1310/ares-marque-plugin/blob/master/images/courtesan-management-route.PNG)

Webportal view of the marque management house route:
![Web-Portal](https://github.com/cailleach1310/ares-marque-plugin/blob/master/images/courtesan-management-house-route.PNG)


### Prerequisites
The marque plugin relies on the fact that 'Courtesan' is set up as a faction (group), and that ranks 'Novice', 'Adept', 'Courtesan', etc have been defined to that faction. When moving on from novice to adept rank, the marque will be started. When the marque is complete and has been acknowledged, the rank will change to (fully marqued) 'Courtesan'. 

## Installation
In the game, run: plugin/install https://github.com/cailleach1310/ares-marque-plugin

### Updating Custom Profile and Chargen Files
If you do not have any existing edits to these custom files, you can use the files in the custom_files folder of this repository as-is. If you do, then you may use them as templates to add the lines of code needed for the marque plugin.

#### aresmush/plugins/profile/custom_char_fields.rb
Update with: custom_files/custom_char_fields.rb

#### aresmush/plugins/chargen/custom_app_review.rb
Update with: custom_files/custom_app_review.rb

### Updating Custom Web Portal Chargen and Profile Files
If you don't have any existing edits to these custom files, you can use the files in the custom_files folder of this repository as-is. If you do, then you may use them as templates to add the lines of code needed for eshtraits.

#### ares-webportal/app/components/chargen-custom.js
Update with: custom_files/chargen-custom.js

#### ares-webportal/app/templates/components/chargen-custom.hbs
Update with: custom_files/chargen-custom.hbs

#### ares-webportal/app/templates/components/chargen-custom-tabs.hbs
Update with: custom_files/chargen-custom-tabs.hbs

#### ares-webportal/app/templates/components/profile-custom.hbs
Update with: custom_files/profile-custom.hbs

#### ares-webportal/app/templates/components/profile-custom-tabs.hbs
Update with: custom_files/profile-custom-tabs.hbs

### Configuration
#### /aresmush/game/config/demographics.yml
Make sure that 'Courtesan' is set as faction. 

    (...)
      groups:
        Faction:
          desc: Character class.
          wiki: factions
          values:
            Courtesan: Servants of Naamah.
    (...)

#### /aresmush/game/config/ranks.yml
Courtesan management relies on courtesan ranks as defined below. If you want to limit certain concepts, set the respective rank values to 'false'.

      ranks:
        (...)
        Courtesan:
          All:
            Novice: true
            Adept: true
            Courtesan: true
            Second: true
            Dowayne: true
            
Make sure that ranks_style is set to 'basic':

      rank_style: basic

#### /aresmush/game/config/chargen.yml

    chargen:
      (...)
      special_blurb: |-
        Some concepts require additional attributes to be set.
        Adept concepts will set their marque at this stage:
        marque/set <state in percent>
      (...)
      stages:
        special:
          title: Special Concepts
          text: |- 
            Some concepts require additional attributes to be set.
            Adept concepts will set their marque at this stage: 

            %xcmarque/set <state in percent>%xn
            %xcmarque%xn - shows the current progress.

#### /aresmush/game/config/website.yml
Add a route to the top bar menu for the admin management page. This route is limited to admin and coder roles for now. 

For example:

      top_navbar:
    (...)
    - title: Special
      menu:
        - title: Manage Marques
          route: courtesan-management
    (...)


## Uninstallation

## License
Same as [AresMUSH](https://aresmush.com/license).
