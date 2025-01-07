class ServiceCategory < ApplicationRecord
  has_many :services, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  
  def to_s
    name
  end
end
