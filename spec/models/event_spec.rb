require 'rails_helper'

describe Event, type: :model do 
  let!(:event) do
    event.create(email_address: "mara@gmail.com", 
      email_type: "Order", event: "send", timestamp: "1465373709")
  end
end


    