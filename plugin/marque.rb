$:.unshift File.dirname(__FILE__)

module AresMUSH
  module Marque

    def self.plugin_dir
      File.dirname(__FILE__)
    end

    def self.version
      "1.0"
    end

    def self.shortcuts
      Global.read_config("marque", "shortcuts")
    end

    def self.achievements
      Global.read_config("marque", "achievements")
    end

    def self.get_cmd_handler(client, cmd, enactor)
      return nil if !cmd.root_is?("marque")

        case cmd.switch
        when "set"
          return SetMarqueCmd
        when "init"
          return InitMarqueCmd
        when "raise"
          return RaiseMarqueCmd
        when "acknowledge"
          return AcknMarqueCmd
        when "list"
          return ListMarqueCmd
        else
          return MarqueCmd
        end

    end

    def self.get_event_handler(event_name)
      case event_name
      when "CronEvent"
        return CronEventHandler
      when "ActionUpdateEvent"
        return ActionUpdateEventHandler
      end
      nil
    end

    def self.get_web_request_handler(request)
       case request.cmd
       when "AcknowledgeMarque"
       return AcknMarqueRequestHandler
       when "InitMarque"
       return InitMarqueRequestHandler
       when "courtesanFull"
       return FullCourtesanRequestHandler
       when "courtesanHouses"
       return CourtesanHousesRequestHandler
       when "courtesanHouse"
       return HouseCourtesanRequestHandler
       when "courtesanGroup"
       return GroupCourtesanRequestHandler
       end
      nil
    end

  end
end
