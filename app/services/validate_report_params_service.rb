class ValidateReportParamsService
  def initialize(params)
    @report_type = params[:report_type]  
    @vm_amount = params[:vm_amount]  
    @unit_type = params[:unit_type]  
    @ascending = params[:ascending]  
  end

  def call
    validate_report_type
    return { err: "Wrong report type" } unless @report_type

    # Пусть мы знаем, что всего 100 ВМ
    # По хорошему следует это запросить 1 раз и сохранить
    return { err: "Wrong vm amount" } unless (@vm_amount && (1..100).include?(@vm_amount.to_i))

    return { err: "Wrong unit type" } unless validate_unit_type

    return { err: "Wrong sort type" } unless validate_ascending

    { report_type: @report_type, vm_amount: @vm_amount, unit_type: @unit_type, ascending: @ascending}
  end

  def validate_report_type
    str_types = %w[by_price by_capacity by_vols_amount by_vols_capacity]
    return if str_types.include?(@report_type)

    return @report_type = @report_type.to_i if (1..4).include?(@report_type.to_i)

    @report_type = nil
  end

  def validate_unit_type
    str_types = %w[cpu ram ssd sata sas]
    is_valid = true if str_types.include?(@unit_type)

    if (1..5).include?(@unit_type.to_i)
      @unit_type = @unit_type.to_i 
      is_valid = true 
    end

    # Если параметр должен отсутствовать
    return false if (['by_price', 1].include?(@report_type) && @unit_type)

    # Если параметр обязательный и валидный
    return true if (['by_capacity', 2].include?(@report_type) && is_valid)

    # Если параметр не обязательный и его нет
    # Если параметр не обязательный и валидный
    return true if (@unit_type.nil? || is_valid)
  end

  def validate_ascending
    return true if (@ascending.nil? || %w[0 1 true false].include?(@ascending))
  end
end