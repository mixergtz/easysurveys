json.array!(@surveys) do |survey|
  json.extract! survey, :id, :title, :description, :state
  json.url survey_url(survey, format: :json)
end
