require "spec_helper"

describe SurveyResponsesController do
  describe "routing" do

    it "routes to #index" do
      get("/survey_responses").should route_to("survey_responses#index")
    end

    it "routes to #new" do
      get("/survey_responses/new").should route_to("survey_responses#new")
    end

    it "routes to #show" do
      get("/survey_responses/1").should route_to("survey_responses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/survey_responses/1/edit").should route_to("survey_responses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/survey_responses").should route_to("survey_responses#create")
    end

    it "routes to #update" do
      put("/survey_responses/1").should route_to("survey_responses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/survey_responses/1").should route_to("survey_responses#destroy", :id => "1")
    end

  end
end
