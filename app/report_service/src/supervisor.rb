require_relative 'vm'

# Class for handling VMs
class Supervisor
  VMS = {}

  def self.add_virtual_machine(vm_data)
    id = vm_data[0].to_i
    raise ArgumentError, "id #{id} already exists" if VMS.key?(id)

    VMS[id] = VirtualMachine.new(*parse_vm_data(vm_data))
  rescue ArgumentError => e
    raise ArgumentError, "Wrong data\n#{e}"
  end

  def self.add_volume(vol_data)
    id = vol_data[0].to_i
    raise ArgumentError, "id #{id} doesn't exists" unless VMS.key?(id)

    VMS[id].add_volume(vol_data[1].to_sym, vol_data[2].to_i)
  rescue ArgumentError => e
    raise ArgumentError, "Wrong data\n#{e}"
  end

  def self.vms
    VMS
  end

  def self.length
    VMS.length
  end

  def self.parse_vm_data(vm_data)
    [
      Integer(vm_data[0]),
      Integer(vm_data[1]),
      Integer(vm_data[2]),
      vm_data[3].to_sym,
      Integer(vm_data[4])
    ]
  end

  private_class_method :parse_vm_data
end
