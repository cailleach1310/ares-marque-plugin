module AresMUSH
  module Marque

    def self.do_marque_raise(target, amount)
      new_marque = target.marque.to_i + amount
      target.update(marque: new_marque < 100 ? new_marque : 100)
    end

    def self.can_manage_marques?(actor)
      actor && actor.has_permission?("manage_marques")
    end

    def self.do_marque_start(target,enactor)
      target.update(marque: 0)
      target.update(action: nil)
      target.update(ranks_rank: "Adept")
      Achievements.award_achievement(target, "debuted")
      message =  target.name + " has started working on the marque. This usually happens after the debut has happened.\n\n(triggered by " + enactor.name + ")"
      Jobs.create_job("MISC", "Marque Started: " + target.name, message, Game.master.system_character)
    end

    def self.do_marque_acknowledgement(target,enactor)
      target.update(marque: nil)
      target.update(action: nil)
      target.update(ranks_rank: "Courtesan")
      Achievements.award_achievement(target, "marque_acknowledged")
      message = target.name + " has finished the marque and had it acknowledged. " + target.name + " is a fully marqued courtesan now.\n\n(triggered by " + enactor.name + ")"
      Jobs.create_job("MISC", "Marque Acknowledged: " + target.name, message, Game.master.system_character)
    end

    def self.adept_chars()
      Character.all.select { |char| char.ranks_rank == 'Adept' }
    end

    def self.courtesan_houses
      chars = Marque.courtesan_chars
      houses = []
      chars.each do |c|
       houses.push c.groups['house']
      end 
      houses.uniq.sort
    end

    def self.courtesan_types
      types = []
      types << 'House'
      types << 'Rank'
      types << 'Gender'
      types << 'Timezone'
      types.sort
    end

   def self.update_action(target) 
     new_action = ""
     if target.ranks_rank == "Novice" 
       new_action = "Debut"
     elsif Marque.is_adept(target) && Marque.marque_complete(target) 
       new_action = "Complete"
     end
     target.update(action: new_action )
   end

   def self.uninstall_plugin
     Character.all.each do |c|
       c.update(marque: nil)
       c.update(action: nil)
     end
   end
    
    def self.general_field(char, field_type, value)
      case field_type

      when 'name'
        Demographics.name_and_nickname(char)
    
      when 'rank'
        char.ranks_rank
   
      when 'group'
        char.group(value)

      when 'handle'
        char.handle ? "@#{char.handle.name}" : ""
        
      when 'marque'
        char.marque

      when 'action'
        char.action

      when 'last_on'
        char.last_on

      else 
        nil
      end
    end

  end
end
