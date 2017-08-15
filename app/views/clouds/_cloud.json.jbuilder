json.extract! cloud, :id, :vm, :cpu, :ram, :storage, :created_at, :updated_at
json.url cloud_url(cloud, format: :json)
