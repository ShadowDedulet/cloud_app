require 'csv'
require_relative '../prices'
require_relative '../supervisor'

# Module providing data loading method
module DataLoader
  def self.load_data(path_to_prices, path_to_vms, path_to_vols)
    CSV.read(path_to_prices).each { |price_data| Prices.add_price(price_data) }
    CSV.read(path_to_vms).each { |vm_data| Supervisor.add_virtual_machine(vm_data) }
    CSV.read(path_to_vols).each { |vol_data| Supervisor.add_volume(vol_data) }
    true
  rescue ArgumentError => e
    puts("Warning: #{e}")
  end
end
