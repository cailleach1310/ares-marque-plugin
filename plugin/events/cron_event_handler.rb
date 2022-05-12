module AresMUSH
  module Marque
    class CronEventHandler
     
      def on_event(event)
        config = Global.read_config("marque", "monthly_raise_cron")
        if Cron.is_cron_match?(config, event.time)
        
          if (Date.today.month == 1) then month = Date::MONTHNAMES[12] 
           else month = Date::MONTHNAMES[Date.today.month - 1] 
          end 
          Global.logger.debug "Monthly marque raise for #{month}."

          amount = Global.read_config("marque", "monthly_raise_amount")
          message = Global.read_config("marque", "monthly_raise_message") 
          title = Global.read_config("marque", "monthly_raise_title") + " " + month
          adepts = Character.all.select { |c| (c.ranks_rank == "Adept") && (c.has_role?("approved")) }
          adepts.each do |a|
            Marque.do_marque_raise(a, amount)
            Mail.send_mail([a.name], title, message, nil)
          end
          names = adepts.map { |a| a.name }
          Jobs.create_job("MISC", 
               "Marque Raise Summary" + " " + month, 
               "Automatic monthly marque raise for #{month} has been handled for the following adepts: #{names.join(", ")}", 
               Game.master.system_character)          
        end

        config = Global.read_config("marque", "action_update_cron")
        if Cron.is_cron_match?(config, event.time)
          Global.logger.debug "Updating actions (marque management)."
          courtesans = Marque.courtesan_chars
          courtesans.each do |b|
            Marque.update_action(b)
          end
        end
      end 
    end
  end
end
