require "rails_helper"

describe "Receive an event", type: :request do

  it "receives an event in json format" do
    headers = { "CONTENT_TYPE" => "text/json" }
    post "/event", '{"Address":"barney@lostmy.name","EmailType":"Shipment","Event":"send","Timestamp":1432820696}', headers
    expect(response).to have_http_status(:success)
  end

  before :each do
    Event.create(email_address: 'mara@lostmy.name',
                 email_type: 'Shipment',
                 event: 'send',
                 timestamp: 1465328158
                 )
  end

  it 'creates new event in database' do
    expect(Event.last[:email_address]).to eq('mara@lostmy.name')
    expect(Event.last[:email_type]).to eq('Shipment')
    expect(Event.last[:event]).to eq('send')
    expect(Event.last[:timestamp]).to eq(1465328158)
  end

end