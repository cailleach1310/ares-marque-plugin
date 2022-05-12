module AresMUSH
 module Marque

  def self.is_adept(char)
    char.ranks_rank == "Adept"
  end

  def self.marque_complete(char)
    char.marque == "100"
  end

  def self.marque_value(char)
    char.marque
  end

  def self.courtesan_chars()
    Character.all.select { |c| (groups = c.groups;groups["faction"] == "Courtesan") && (c.has_role?("approved")) }
  end

 end
end
