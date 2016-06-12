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

  it 'calculates the rates and rounds to two decimal points' do
    rates = [{email_type: "Order",
              send: 227,
              open: 128,
              click: 24,
              open_rate: 0,
              click_rate: 0
              }]
    expect(Event.calculate_rates(rates)).to eq([email_type: "Order",
                                                send: 227,
                                                open: 128,
                                                click: 24,
                                                open_rate: 0.56,
                                                click_rate: 0.11
                                                ])
  end

  it "doesn't calculate rates if there were no emails sent" do
    rates = [{email_type: "Order",
              send: 0,
              open: 0,
              click: 0,
              open_rate: 0.56,
              click_rate: 0.11
              }]
    expect(Event.calculate_rates(rates)).to eq([email_type: "Order",
                                                send: 0,
                                                open: 0,
                                                click: 0,
                                                open_rate: 0,
                                                click_rate: 0
                                                ])
  end

end