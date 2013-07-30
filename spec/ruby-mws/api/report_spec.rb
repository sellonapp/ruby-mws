require 'spec_helper'

describe MWS::API::Product do

  before :all do
    EphemeralResponse.activate
    @mws = MWS.new(auth_params)
    @timestamp = Time.now.utc.iso8601
  end

  context "requests" do

    describe "request_report" do
      it "should receive a list of products for id" do
        response = @mws.reports.request_report :last_updated_after => "2012-01-15T13:07:26-05:00" , :timestamp => @timestamp
        response.should be_an_instance_of MWS::API::Response
        response.report_request_info.should have_key :report_request_id
        @report_request_id = response.report_request_info.report_request_id
      end
    end

    describe "get_report_request_list" do
      it "should receive a report of request list" do
        response = @mws.reports.get_report_request_list :last_updated_after => "2012-01-15T13:07:26-05:00" , :timestamp => @timestamp
        response.should be_an_instance_of MWS::API::Response
        response.report_request_info.last.should have_key :report_processing_status
        @report_id = response.report_request_info.last.report_processing_status
      end
    end

    describe "get_report_list" do
      it "should receive a list reports" do
        response = @mws.reports.get_report :last_updated_after => "2012-01-15T13:07:26-05:00" , :timestamp => @timestamp
      end
    end

  end

end