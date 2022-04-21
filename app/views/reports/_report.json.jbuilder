json.extract! report, :id, :report_type, :vm_amount, :output, :created_at, :updated_at
json.url report_url(report, format: :json)
