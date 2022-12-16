module AresMUSH
  module Marque
    class ListMarqueCmd
      include CommandHandler
      
      def check_can_view
        return nil if enactor.has_permission?("manage_marques")
        return "You are not allowed to use this command."
      end	

      def handle
        if enactor.has_role?("admin")
           adept_chars = Marque.adept_chars
        else
           house = enactor.groups["house"]
           adept_chars = Marque.adept_chars.select {|c| c.groups['house'] == house }
        end

        template = MarqueTemplate.new adept_chars
	client.emit template.render
      end 
    end  
  end
end

