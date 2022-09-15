module AresMUSH
  module Profile
    class CustomCharFields
      
      def self.get_fields_for_viewing(char, viewer)
        return { marque: char.marque.to_i,
                 house_list: Marque.build_web_house_list(char, viewer) }
      end
    
      def self.get_fields_for_editing(char, viewer)
       return {}
       end

      def self.get_fields_for_chargen(char)
         return { marque: Website.format_input_for_html(char.marque),
           cg_adept: char.ranks_rank == "Adept" }
      end
      
      def self.save_fields_from_profile_edit(char, char_data)
        return {}
      end
      
      def self.save_fields_from_chargen(char, chargen_data)
        char.update(marque: chargen_data[:custom][:marque])
        return []
      end
      
    end
  end
end
