
class Unit
    attr_accessor :type, :force

    BASE_FORCE = { spearman: 5, archer: 10, knight: 20 }
    TRAINING_BONUS = { spearman: 3, archer: 7, knight: 10 }
    TRAINING_COST = { spearman: 10, archer: 20, knight: 30 }
  
    def initialize(type)
        @type = type
        @force = BASE_FORCE[type]
    end

    def train(army)
        cost = TRAINING_COST[type]
        if army.gold >= cost
          army.gold -= cost
          @force += TRAINING_BONUS[type]
        else
          raise "Not enough gold to train the unit."
        end
    end
end
  
  # Define the Army class which aggregates units and handles battles
class Army
    attr_accessor :civilization, :units, :gold, :battle_history

    CIVILIZATION_CONFIG = {
        'Chinese'    => { spearman: 2, archer: 25, knight: 2 },
        'English'  => { spearman: 10, archer: 10, knight: 10 },
        'Byzantine'=> { spearman: 5, archer: 8, knight: 15 }
    }
  
    def initialize(civilization)
        @civilization = civilization
        @gold = 1000
        @units = ''
        @battle_history = []
    end
end

army1 = Army.new('Chinese')
army2 = Army.new('English')

puts "Army1: #{army1.civilization}, Gold: #{army1.gold}"
puts "Army2: #{army2.civilization}, Gold: #{army2.gold}"