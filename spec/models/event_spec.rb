require "rails_helper"

RSpec.describe "Receive an event", type: :request do

  it "receives an event in json format" do
    headers = { "CONTENT_TYPE" => "text/json" }
    post "/event", '{"Address":"barney@lostmy.name","EmailType":"Shipment","Event":"send","Timestamp":1432820696}', headers
    expect(response).to have_http_status(:success)
  end

end