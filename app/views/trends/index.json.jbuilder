json.array!(@trends) do |trend|
  json.extract! trend, :id, :kind, :rate_id
  json.url trend_url(trend, format: :json)
end
