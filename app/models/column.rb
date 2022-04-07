class Column < ApplicationRecord
    has_many :elevators
    belongs_to :battery
    has_many :interventions
end
