class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :follows, as: :target, dependent: :destroy

  validates :name, presence: true
  validates :profile, presence: true

  acts_as_paranoid

  scope :alphabet, ->{order name: :ASC}
  scope :_page,
    ->(page){paginate page: page, per_page: Settings.paginate.per_page}

  def self.to_xsl options = {}
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |author|
        csv << author.attributes.values_at(*column_names)
      end
    end
  end
end
