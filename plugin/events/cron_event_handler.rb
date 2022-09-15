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
          title = "Monthly Marque Raise for " + month
          adepts = Character.all.select { |c| (c.ranks_rank == "Adept") && (c.has_role?("approved")) }
          if !adepts 
             return nil
          end
          adepts.each do |a|
            Marque.do_marque_raise(a, amount)
            message = t('marque.monthly_raise_message', :name => a.name, :current => a.marque, :monthly_raise_amount => amount)
            Mail.send_mail([a.name], title, message, nil)
          end
          names = adepts.map { |a| a.name + " --> " + a.marque.to_s }
          report = "\n\n"
          names.each do |n|
             report = report + n + "%\n"
          end     
          Jobs.create_job("MISC", 
               "Marque Raise Summary for " + month, 
               "Automatic monthly marque raise for #{month} has been handled for the following adepts: #{report}",
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
