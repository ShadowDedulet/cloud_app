class Order < ApplicationRecord
  # validates :name, length: { maximum: 10 }
  after_validation :calc_cost, on: [:create, :update]

  scope :high_cost, -> { where(cost: 1000..) }
  scope :vip_failed, -> { failed.high_cost }
  scope :created_before, -> (time) { where('created_at < ?', time) }

  enum status: %w[unavailable created started failed removed] 

  belongs_to :user
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :networks

  private



  def calc_cost
    prices = {
      sas: 100,
      sata: 200,
      ssd: 300,
      ram: 150,
      cpu: 1000
    } 
    self.cost = self.options['cpu'] * prices[:cpu] + self.options['ram'] * prices[:ram]

  end
end
