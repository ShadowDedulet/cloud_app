require_relative 'diskspace'

# Class for VM data
class VirtualMachine
  attr_reader :id, :cpu, :ram, :disks

  # @param [Array] vm_data [id, cpu, ram, hdd_t, hdd]
  def initialize(id, cpu, ram, hdd_t, hdd)
    @id = id.to_i
    @cpu = cpu.to_i
    @ram = ram.to_i
    @disks = DiskSpace.new(hdd_t.to_sym, hdd.to_i)
  end

  def add_volume(type, capacity)
    @disks.add_vol(type, capacity.to_i)
  end
end
