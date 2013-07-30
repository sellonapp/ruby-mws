module MWS
  module API
    class Report < Base
      
      def_request [:request_report],
        :verb => :get,
        :uri => '/',
        :version => '2009-01-01',
        :id_type => "ASIN",
        :report_type => "_GET_FLAT_FILE_OPEN_LISTINGS_DATA_"

      def_request [:get_report_request_list],
        :verb => :get,
        :uri => '/',
        :version => '2009-01-01',
        :lists => {
          :report_type_list => "ReportTypeList.Type"
        },
        :report_type => "_GET_FLAT_FILE_OPEN_LISTINGS_DATA_"
    end
  end
end