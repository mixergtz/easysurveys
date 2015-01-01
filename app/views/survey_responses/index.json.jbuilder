json.array!(@survey_responses) do |survey_response|
  json.extract! survey_response, :id, :survey_id, :question_id, :answer_id
  json.url survey_response_url(survey_response, format: :json)
end
