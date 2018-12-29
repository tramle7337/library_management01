class Request < ApplicationRecord
  belongs_to :user
  has_many :request_details, dependent: :destroy
  has_many :books, through: :request_details

  validates :from_day, presence: true
  validates :to_day, presence: true

  before_create :set_day

  enum status: {pending: 0, accept: 1, deny: 2}

  scope :newest, ->{order created_at: :DESC}
  scope :_page,
    ->(page){paginate page: page, per_page: Settings.paginate.per_page}

  def total_book
    request_details.map{|rd| rd.valid? ? rd.number : 0}.sum
  end

  def set_day
    self.from_day = Time.current.in_time_zone("Hanoi")
    self.to_day = from_day + 7.days
  end
end
