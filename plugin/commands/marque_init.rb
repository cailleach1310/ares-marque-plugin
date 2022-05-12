module AresMUSH
  module Marque
    class InitMarqueCmd
      include CommandHandler
      
      attr_accessor :name, :num
      
      def parse_args
        self.name = trim_arg(cmd.args)
      end
      
      def required_args
        [ self.name ]
      end
      
      def handle
          ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
          if !Marque.can_manage_marques?(enactor)
            client.emit_failure "You aren't allowed to trigger this command."
            return nil
          elsif model.ranks_rank != "Novice"
            client.emit_failure "Initialising marque is only possible for a novice after their debut!"
            return nil
         else 
            Marque.do_marque_start(model)
            client.emit_success "The marque has been set to zero! #{model.name} now has new status of adept."
            return true
          end   
        end
      end  
    end
  end
end
