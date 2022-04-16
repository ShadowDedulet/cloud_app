# Service providing methods for:
# - parsing needed fields from query
# - checking if parameters from query are available
module VmParamsService
  def self.parse_params(params)
    raise ArgumentError, 'Wrong hdd type' unless %w[sata sas ssd].include?(params[:hdd_type])
    raise ArgumentError, 'Wrong os' unless %w[windows linux].include?(params[:os])

    {
      'os' => params[:os],
      'cpu' => Integer(params[:cpu]),
      'ram' => Integer(params[:ram]),
      'hdd_type' => params[:hdd_type],
      'hdd_capacity' => Integer(params[:hdd_capacity])
    }
  end

  def self.check_specs(specs, params)
    specs.any? { |spec| check_spec(spec, params) }
  end

  def self.check_spec(spec, params)
    params.each do |k, v|
      return false unless spec.key?(k)

      if k == 'hdd_capacity'
        type = params['hdd_type']
        return false unless spec['hdd_capacity'].include?(type)

        range = spec['hdd_capacity'][type]['from']..spec['hdd_capacity'][type]['to']
        return false unless range.include?(v)

        return true
      end

      return false unless spec[k].include?(v)
    end
    true
  end
end
