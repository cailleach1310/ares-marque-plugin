module AresMUSH
  module Marque
    class MarqueCmd
      include CommandHandler
      
      attr_accessor :name

      def parse_args
        self.name = cmd.args ? titlecase_arg(cmd.args) : enactor_name
      end
      
      def check_can_view
         return nil if self.name == enactor_name
         return nil if enactor.has_permission?("view_bgs")
         return "You're not allowed to view other peoples' marque information."
      end    
      
      def handle
        ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
          template = BorderedDisplayTemplate.new model.marque, "#{model.name}'s Marque"
          client.emit template.render
        end
      end
    end
  end
end
