class Service < ApplicationRecord
  belongs_to :service_category
  validates_presence_of :name, :service_category_id
  
  def to_s
    name
  end
end
