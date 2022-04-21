# Module providing report printing method
module Printer
  def self.print_report(report)
    print_header
    report.each { |row| print_row(row) }
    print("\n")
  end

  def self.print_header
    cols = %w[id cpu ram hdd_t hdd_c vol_t vol_c ...]
    print("#{print_array(cols).ljust(80)}value\n")
  end

  def self.print_row(row)
    print("#{print_vm(row[0]).ljust(80)}#{row[1]}\n")
  end

  def self.print_vm(vm_)
    out = print_array([vm_.id, vm_.cpu, vm_.ram]) + print_array(vm_.disks.hdd)
    out + vm_.disks.vols.sum('') { |d| print_array(d) }
  end

  def self.print_array(arr)
    arr.sum('') { |val| val.to_s.ljust(6) }
  end

  private_class_method :print_header, :print_row, :print_vm, :print_array
end
