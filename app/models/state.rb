class State < ActiveRecord::Base
  belongs_to :country
  has_many   :addresses
  has_many   :tax_rates
  belongs_to :shipping_zone
  
  validates :name,              :presence => true
  validates :abbreviation,      :presence => true
  validates :country_id,        :presence => true
  validates :shipping_zone_id,  :presence => true
  
  def abbreviation_name(append_name = "")
    ([abbreviation, name].join(" - ") + " #{append_name}").strip
  end

  def abbrev_and_name
    abbreviation_name
  end

  def self.form_selector
    find(:all, :order => 'country_id ASC, abbreviation ASC').collect { |state| [state.abbrev_and_name, state.id] }
  end
  
  def self.all_with_country_id(c_id)
    where(["country_id = ?", c_id])
  end
end
