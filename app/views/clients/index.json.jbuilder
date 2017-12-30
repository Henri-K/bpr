json.array! @clients do |c|
  json.id c.id
  json.name c.name
  json.email c.email
end