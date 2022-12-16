module AresMUSH
  module Marque
    class AcknMarqueCmd
      include CommandHandler
      
      attr_accessor :name
 
      def parse_args
        self.name = trim_arg(cmd.args)
      end
      
      def required_args
        [ self.name ]
      end
       
      def handle
        ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
          if !Marque.can_manage_marques?(enactor)
            client.emit_failure "You don't have the permission to trigger this command."
            return nil
          elsif model.ranks_rank != "Adept"
            client.emit_failure "Only adept characters can have their marque acknowledged!"
            return nil
          elsif model.marque != "100"
            client.emit_failure "The marque is not yet complete!"
            return nil
          elsif (!enactor.is_admin?) && (model.groups["house"] != enactor.groups["house"])
            client.emit_failure "You aren't allowed to acknowledge the Marque of another house!"
            return nil
          else 
            Marque.do_marque_acknowledgement(model,enactor)
            client.emit_success "The marque has been acknowledged! #{model.name} now has new status of fully marqued courtesan."
            return true
          end
        end
      end  
    end
  end
end
