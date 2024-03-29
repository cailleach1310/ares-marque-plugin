module AresMUSH
  module Marque
    class DowayneManagementDataBuilder
      def build(char, viewer)
        has_permission = (char == viewer) || (viewer && viewer.is_admin?)
        if !(char.has_permission?("manage_marques")) || !(has_permission)
           return nil
        end

        fields = Global.read_config("marque", "courtesan_fields")
        titles = fields.map { |f| f['title'] }
        house = char.groups["house"]
        
        chars = Marque.courtesan_chars.select {|c| c.groups['house'] == house }
        chars = chars.sort_by { |c| c.name}

        courtesans = []
        
        chars.each do |c|
          char_data = {}
          char_data['char'] = {
               name: c.name,
               icon: Website.icon_for_char(c)  }
          fields.each do |field_config|
            field = field_config["field"]
            title = field_config["title"]
            value = field_config["value"]

            char_data[title] = Marque.general_field(c, field, value)
          end
          
          courtesans << char_data
        end
        
        {
          titles: titles,
          courtesans: courtesans
        }
      end
    end
  end
end

