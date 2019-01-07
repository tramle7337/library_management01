class Publisher < ApplicationRecord
  has_many :books

  validates :name, presence: true,
    length: {maximum: Settings.publisher.name.max_length}
  validates :address, presence: true,
    length: {maximum: Settings.publisher.address.max_length}

  scope :search_publisher, -> search {
    where("publishers.name LIKE ?",
    "%#{search.strip}%") if search.present?
  }

  def self.to_xsl options = {}
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |publisher|
        csv << publisher.attributes.values_at(*column_names)
      end
    end
  end
end
