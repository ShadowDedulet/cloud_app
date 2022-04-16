module OrdersSpecData
  TEST_SPECS = {
    cpu: 4,
    ram: 4,
    hdd_capacity: 50,
    hdd_type: 'sata',
    os: 'linux'
  }

  PRICE = 61_924

  SPECS = {
    specs:
    [
      {
        os: ['linux'],
        cpu: [1, 2, 4, 8, 16],
        ram: [1, 2, 4, 8, 16, 32],
        hdd_type: %w[sata sas],
        hdd_capacity: {
          sata: {
            from: 10,
            to: 100
          },
          sas: {
            from: 20,
            to: 150
          }
        }
      },
      {
        os: ['windows'],
        cpu: [4, 8, 16],
        ram: [4, 8, 16, 32],
        hdd_type: %w[sata sas],
        hdd_capacity: {
          sata: {
            from: 20,
            to: 100
          },
          sas: {
            from: 20,
            to: 150
          }
        }
      },
      {
        os: ['linux'],
        cpu: [1, 2, 4],
        ram: [4, 8, 16],
        hdd_type: ['ssd'],
        hdd_capacity: {
          ssd: {
            from: 50,
            to: 200
          }
        }
      },
      {
        os: ['windows'],
        cpu: [4, 8],
        ram: [8, 16, 32],
        hdd_type: ['ssd'],
        hdd_capacity: {
          ssd: {
            from: 100,
            to: 500
          }
        }
      }
    ]
  }

  def self.test_specs
    TEST_SPECS
  end

  def self.available_specs
    SPECS
  end

  def self.correct_price
    PRICE
  end
end
