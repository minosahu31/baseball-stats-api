# Player model
class Player < ApplicationRecord
  belongs_to :position
  belongs_to :team

  self.per_page = 25
end
