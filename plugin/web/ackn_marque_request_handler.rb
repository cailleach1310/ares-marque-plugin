module AresMUSH
  module Marque
    class AcknMarqueRequestHandler
      def handle(request)
        enactor = request.enactor
        char = Character.find_one_by_name request.args[:name]

        error = Website.check_login(request, true)
        return error if error

        request.log_request

        if (!char)
          return { error: t('webportal.not_found') }
        end

        if (!Marque.can_manage_marques?(enactor))
          return { error: t('dispatcher.not_allowed') }
        end
        
        Global.logger.info "The adept #{char.name} had the marque acknowledged (by #{enactor.name}). #{char.name} is a fully marqued courtesan now."
        Marque.do_marque_acknowledgement(char,enactor)
        {
            name: char.name
        }
      end
    end
  end
end
