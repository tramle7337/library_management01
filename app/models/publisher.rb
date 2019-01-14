class Publisher < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.publisher.name.max_length}
  validates :address, presence: true,
    length: {maximum: Settings.publisher.address.max_length}

  acts_as_paranoid

  scope :_page,
    ->(page){paginate page: page, per_page: Settings.paginate.per_page}

  def self.to_xsl options = {}
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |publisher|
        csv << publisher.attributes.values_at(*column_names)
      end
    end
  end
end
