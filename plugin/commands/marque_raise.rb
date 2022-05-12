module AresMUSH
  module Marque
    class RaiseMarqueCmd
      include CommandHandler
      
      attr_accessor :name, :num

      def parse_args
        args = cmd.parse_args( /(?<name>[^\=]+)\=(?<num>.+)/)
        self.name = titlecase_arg(args.name)
        self.num = integer_arg(args.num)
      end

      def required_args
        [ self.name, self.num ]
      end      
      
      def handle
        ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
          if !enactor.has_role?("admin")
            client.emit_failure "Only staff are allowed to trigger this command."
            return nil
          elsif model.ranks_rank != "Adept"
            client.emit_failure "Only adept characters can have their marque raised!"
            return nil
          elsif !model.has_role?("approved")
            client.emit_failure "Only approved adepts can have their marque raised!"
            return nil
          else 
            Marque.do_marque_raise(model, self.num)
            client.emit_success "#{model.name}'s marque has been raised to #{model.marque} percent."
            Marque.update_action(model)
            return true
          end
        end
      end  
    end
  end
end
