require_relative 'supervisor'
require_relative 'prices'

# Module providing repoting data
module Reporter
  def self.find_by_price(amount = Supervisor.length, ascending: false)
    vm_and_price = Supervisor.vms.map { |_id, vm| [vm, get_vm_price(vm)] }.sort_by { |vm, price| [price, vm.id] }
    vm_and_price.reverse! unless ascending
    vm_and_price.first(amount)
  end

  def self.find_by_capacity(amount = Supervisor.length, type, ascending: false)
    vm_and_capacity =
      Supervisor.vms.map { |_id, vm| [vm, get_vm_capacity(vm, type)] }.sort_by { |vm, cap| [cap, vm.id] }
    vm_and_capacity.reverse! unless ascending
    vm_and_capacity.first(amount)
  end

  def self.find_by_volumes_amount(amount = Supervisor.length, hdd_type = nil, ascending: false)
    vm_and_capacity =
      Supervisor.vms.map { |_id, vm| [vm, get_vm_vols_amount(vm, hdd_type)] }.sort_by { |vm, cap| [cap, vm.id] }
    vm_and_capacity.reverse! unless ascending
    vm_and_capacity.first(amount)
  end

  def self.find_by_volumes_capacity(amount = Supervisor.length, hdd_type = nil, ascending: false)
    vm_and_capacity =
      Supervisor.vms.map { |_id, vm| [vm, get_vm_vols_capacity(vm, hdd_type)] }.sort_by { |vm, cap| [cap, vm.id] }
    vm_and_capacity.reverse! unless ascending
    vm_and_capacity.first(amount)
  end

  # UNITS

  def self.get_unit_price(type, val)
    Prices.find_by_type(type) * val
  end

  # VMS

  def self.get_vm_price(vm_)
    units = [[:cpu, vm_.cpu], [:ram, vm_.cpu], vm_.disks.hdd] # base static-size elements
    base = units.sum(0) { |el| get_unit_price(el[0], el[1]) }
    vm_.disks.vols.sum(base) { |vol| get_unit_price(vol[0], vol[1]) }
  end

  def self.get_vm_capacity(vm_, type_)
    vm_.send(type_)
  rescue NoMethodError
    hdd, vols = vm_.disks.find_by_type(type_)

    vols.map(&:to_i).sum(hdd.to_i)
  end

  # VMS (volumes)

  def self.get_vm_vols_amount(vm_, type_)
    _, vols = vm_.disks.find_by_type(type_)
    vols.length
  end

  def self.get_vm_vols_capacity(vm_, type_)
    _, vols = vm_.disks.find_by_type(type_)
    vols.map(&:to_i).sum(0)
  end

  private_class_method :get_unit_price
  private_class_method :get_vm_price, :get_vm_capacity
  private_class_method :get_vm_vols_amount, :get_vm_vols_capacity
end
