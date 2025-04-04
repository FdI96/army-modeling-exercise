
class Unit
    attr_accessor :type, :force

    BASE_FORCE = { spearman: 5, archer: 10, knight: 20 }
    TRAINING_BONUS = { spearman: 3, archer: 7, knight: 10 }
    TRAINING_COST = { spearman: 10, archer: 20, knight: 30 }
    TRANSFORMATION_COST = {
        spearman: { archer: 30 },
        archer: { knight: 40 }
    }
  
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

    def transform(army, new_type)
        valid_transformation = TRANSFORMATION_COST[type] && TRANSFORMATION_COST[type][new_type]
        if valid_transformation
          cost = TRANSFORMATION_COST[type][new_type]
          if army.gold >= cost
            army.gold -= cost
            @type = new_type
            @force = BASE_FORCE[new_type]
          else
            raise "Not enough gold to transform the unit"
          end
        else
          raise "Invalid transformation from #{type} to #{new_type}"
        end
    end
end
  
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
        @units = create_initial_units
        @battle_history = []
    end

    def total_force
        units.reduce(0) { |sum, unit| sum + unit.force }
    end

    def attack(other_army)
        if total_force > other_army.total_force
          other_army.remove_strongest_units(2)
          @gold += 100
          @battle_history << "won against #{other_army.civilization}"
        elsif total_force < other_army.total_force
          remove_strongest_units(2)
          other_army.gold += 100
          other_army.battle_history << "won against #{@civilization}"
        else
          remove_strongest_units(1)
          other_army.remove_strongest_units(1)
          @battle_history << "tie with #{other_army.civilization}"
          other_army.battle_history << "Tie with #{@civilization}"
        end
    end

    def remove_strongest_units(count)
        count.times do
          strongest = units.max_by(&:force)
          units.delete(strongest) if strongest
        end
    end
    


    private

    def create_initial_units
        config = CIVILIZATION_CONFIG[@civilization]
        raise "Unknown civilization" unless config

        config.flat_map do |unit_type, number|
        Array.new(number) { Unit.new(unit_type) }
        end
    end
end
