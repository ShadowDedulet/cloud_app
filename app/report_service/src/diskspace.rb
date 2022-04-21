# Class for main and extra disks
class DiskSpace
  attr_reader :hdd, :vols

  def initialize(type, capacity)
    @hdd = [type, capacity]
    @vols = []
  end

  def add_vol(type, capacity)
    @vols << [type, capacity]
  end

  def find_by_type(type)
    hdd = @hdd if @hdd[1] == type
    vols = @vols.map { |vol| vol[1] if vol[0] == type }.compact
    [hdd, vols]
  end
end
