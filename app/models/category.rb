class Category < ApplicationRecord
    has_many :todos, dependent: :destroy
    validates :name, presence: true
end
