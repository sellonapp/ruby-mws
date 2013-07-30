require 'spec_helper'

describe MWS::API::Product do

  before :all do
    EphemeralResponse.activate
    @mws = MWS.new(auth_params)
    @timestamp = Time.now.utc.iso8601
  end

  context "requests" do
    describe "get_matching_product_for_id" do
      it "should receive a list of products for id" do
        response = @mws.products.get_matching_product_for_id :last_updated_after => "2012-01-15T13:07:26-05:00" ,
          :timestamp => @timestamp, :id_list => ['B008MUCEDG', 'B008MUJW3G']
        response.should be_an_instance_of Array
        response.first.should be_an_instance_of MWS::API::Response
      end
    end

    # describe "get_matching_product" do
    #   it "should receive a list of products" do
    #     products = @mws.products.get_matching_product :timestamp => @timestamp,
    #       :next_token => "zwR7fTkqiKp/YYuZQbKv1QafEPREmauvizt1MIhPYZZl3LSdPSOgN1byEfyVqilNBpcRD1uxgRxTg2dsYWmzKd8ytOVgN7d/KyNtf5fepe2OEd7gVZif6X81/KsTyqd1e64rGQd1TyCS68vI7Bqws+weLxD7b1CVZciW6QBe7o2FizcdzSXGSiKsUkM4/6QGllhc4XvGqg5e0zIeaOVNezxWEXvdeDL7eReo//Hc3LMRF18hF5ZYNntoCB8irbDGcVkxA+q0fZYwE7+t4NjazyEZY027dXAVTSGshRBy6ZTthhfBGj6Dwur8WCwcU8Vc25news0zC1w6gK1h3EdXw7a3u+Q12Uw9ZROnI57RGr4CrtRODNGKSRdGvNrxcHpI2aLZKrJa2MgKRa+KsojCckrDiHqb8mBEJ88g6izJN42dQcLTGQRwBej+BBOOHYP4"
    #     response.first.should be_an_instance_of MWS::API::Response
    #   end
    # end
  end

end