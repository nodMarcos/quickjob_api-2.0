class Service < ApplicationRecord
  searchkick text_middle: %i[name], index_name: "service_#{Rails.env}", case_sensitive: false
  belongs_to :service_category
  validates_presence_of :name, :service_category_id

  def self.scored_fields
    ['service_category_name^10', 'name^5']
  end

  def self.search_select
    new.search_data.keys
  end

  def search_data
    attributes.merge(
      service_category_name: service_category_name,
      service_category: service_category
    )
  end

  def service_category_name
    service_category&.name
  end
  
  def to_s
    name
  end
end
