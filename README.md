# Ares Marque Plugin
A plugin for handling marque stuff on games of Kushiel theme. 

## Credits
Lyanna @ AresCentral

## Overview
Anyone familiar with the books or games of Kushiel theme will know that the marque is an aspect that only affects courtesan concepts, and more particularly, only novices and adepts. In fact the marque does not necessarily require code at all - it could be handled simply on basis of +requests, with the player declaring at some point they are starting or have completed the marque. On other games of the theme, I've seen it handled with code support. Based on my code developed for the pennmush game *Marsilikos*, I've made this marque plugin my personal coding project, to learn the way AresMUSH is wired together. Now I'm putting it out there for anyone who'd like to use it. If you want some code-side marque support in your Kushiel-based game, go ahead, use it as is or adapt it to your needs.

The marque plugin requires only adjustments in the custom AresMUSH files, so it shouldn't affect future merges and version upgrades. I've developed and tested this with v0.106 - v0.108.

### What this plugin covers
* Chargen: Setting marque during chargen.
* Profile: Making the marque part of the profile.
* Staff-side marque management commands from within the game.
* Staff-side marque management route from the webportal.
* Awarding achievements when completing phases of novice and adept.
* Cron job based monthly marque progress for off camera assignations.
* Additional raises can be applied by staff when applicable.

## Screenshots
### In game view of the 'marque/list' command
![marque-list](/images/marque_list_command.PNG)

This staff command can be used to check current marque progresses on the client.

### Webportal view of the courtesan management route
![courtesan-management](/images/courtesan_management_route.PNG)

The courtesan management route is based heavily on the census code with some modifications. The route is only available to admin and coder roles.

This view may look spammy, so please note the nav bar at the top that allows you to switch to a view of a single house/salon. The list is generated dynamically from all houses of approved courtesan characters. Unplayed houses won't get listed.

Besides providing an overview of marque progresses, buttons will show in the 'Action' column if a staff-side action may be required. Novice characters will have their debut upcoming. Adepts who have completed their marque want to have it acknowledged. Both situations require communication about scenes to be had leading up to this change of status, and the eventual press of the button to trigger the start of a new phase.

### Webportal view of the marque management house route
![courtesan-management-house](/images/courtesan_management_house_route.PNG)

Here we have the view for a single house. For now, this view is limited to admin and coder roles. It could be an option to make this available to house leaders such as dowaynes and seconds as well. Maybe something to be tackled in the next version. 

## Prerequisites
The marque plugin relies on the fact that 'Courtesan' is set up as a faction (group), and that ranks 'Novice', 'Adept', 'Courtesan', etc have been defined to that faction. When moving on from novice to adept rank, the marque will be started. When the marque is complete and has been acknowledged, the rank will change to (fully marqued) 'Courtesan'. Please make sure to add availaible courtesan houses and salons to the group 'House', as **marque/list** and the webportal courtesan management pages will need this for their output. 

## Installation
In the game, run: plugin/install https://github.com/cailleach1310/ares-marque-plugin

### Updating Custom Profile and Chargen Files
If you do not have any existing edits to these custom files, you can use the files in the custom_files folder of this repository as-is. If you do, then you may use them as templates to add the lines of code needed for the marque plugin.

#### aresmush/plugins/profile/custom_char_fields.rb
Update with: custom_files/custom_char_fields.rb

#### aresmush/plugins/chargen/custom_app_review.rb
Update with: custom_files/custom_app_review.rb

### Updating Custom Web Portal Chargen and Profile Files
If you don't have any existing edits to these custom files, you can use the files in the custom_files folder of this repository as-is. If you do, then you may use them as templates to add the lines of code needed for the marque plugin.

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

## Configuration

### Other plugins

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

Define available courtesan houses / salons for the game in the group 'House'.

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

### marque.yml 
You don't have to modify the marque.yml for the plugin to work, but you can make adjustments here. The keys in the yaml are explained below.

#### achievements
The plugin comes with two predefined story achievements, 'debuted' and 'acknowledged'. More can be added here.

#### action_update_cron 
The plugin is configured to check twice per hour for action updates (-> start marque, -> acknowledge marque).

#### courtesan_fields
These fields will be shown in the webportal courtesan management route.

#### marque_fields
These fields will be shown in the game client command **marque/list**.

#### monthly_raise_amount
This is the monthly marque raise for 'off-camera' assignations in percent. It is set to '3' but this can be adjusted. A value of '3' means that the marque will take 3 years and one month to complete after the debut. A higher value will have it complete faster. Additional raises for assignations referenced in rp can be handled through +requests.

#### monthly_raise_cron
Per default, the monthly marque raise cron job runs at 1:15 am on the first of each month. You can disable the job by replacing the value with '{}'.

#### monthly_raise_message
This is the text of the +mail that will be sent to adepts. If you change the monthly_raise_amount, make sure to adjust this text accordingly.

#### monthly_raise_title
The title of the monthly raise mail for adepts (month will be added), and also for the +job that will created to notify staff.

#### permissions
In preparation of future adjustments, the permission: 'manage_marques' has been defined.

#### shortcuts
Here is a space where you can define shortcuts for the commands.


## Uninstallation

## License
Same as [AresMUSH](https://aresmush.com/license).
