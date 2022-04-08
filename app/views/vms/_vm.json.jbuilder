json.extract! vm, :id, :name, :cpu, :ram, :created_at, :updated_at
json.url vm_url(vm, format: :json)
