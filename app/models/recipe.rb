class Recipe < ApplicationRecord
  before_save { self.name = name.titleize }

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
  validates :chef_id, presence: true

  belongs_to :chef
end
