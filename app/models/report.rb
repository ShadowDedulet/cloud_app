class Report < ApplicationRecord
  enum report_type: {
    by_price: 1,
    by_capacity: 2,
    by_vols_amount: 3,
    by_vols_capacity: 4
  }

  enum unit_type: {
    cpu: 1,
    ram: 2,
    ssd: 3,
    sata: 4,
    sas: 5
  }
end
