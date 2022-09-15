module AresMUSH
  module Marque
    class InitMarqueRequestHandler
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
        
        Global.logger.info "The novice #{char.name} has debuted and has become an adept in Naamah's service (triggered by #{enactor.name}). #{char.name} have started work on their marque ."
        Marque.do_marque_start(char,enactor)
        {
            name: char.name
        }
      end
    end
  end
end
