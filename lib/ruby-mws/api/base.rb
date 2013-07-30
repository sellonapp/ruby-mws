# This class serves as a parent class to the API classes.
# It shares connection handling, query string building, ?? among the models.

module MWS
  module API

    class Base
      include HTTParty
      # debug_output $stderr  # only in development
      # format :xml
      # headers "User-Agent"   => "ruby-mws/#{MWS::VERSION} (Language=Ruby/1.9.3-p0)"
      # headers "Content-Type" => "text/xml"

      attr_accessor :response

      def initialize(connection)
        @connection = connection
        @saved_options = {}
        @next = {}
        self.class.base_uri "https://#{connection.host}"
      end

      def self.def_request(requests, *options)
        [requests].flatten.each do |name|
          self.class_eval %Q{
            @@#{name}_options = options.first
            def #{name}(params={})
              send_request(:#{name}, params, @@#{name}_options)
            end
          }
        end
      end

      def send_request(name, params, options)
        # prepare all required params...
        params = [params, options, @connection.to_hash].inject :merge
        
        # default/common params
        params[:action]            ||= name.to_s.camelize
        params[:signature_method]  ||= 'HmacSHA256'
        params[:signature_version] ||= '2'
        params[:timestamp]         ||= Time.now.iso8601
        params[:version]           ||= '2009-01-01'

        params[:lists] ||= {}
        params[:lists][:marketplace_id]   ||= "MarketplaceId.Id" unless params[:marketplace_id]
        params[:lists][:report_type_list] ||= "_GET_FLAT_FILE_OPEN_LISTINGS_DATA_"

        query = Query.new params
        @response = Response.parse self.class.send(params[:verb], query.request_uri), name, params
        if @response.respond_to?(:next_token) and @next[:token] = @response.next_token  # modifying, not comparing
          @next[:action] = name.match(/_by_next_token/) ? name : "#{name}_by_next_token"
        end
        if @response.parsed_response.is_a?(String)
          @response = CSV.generate({col_sep: "\t"}) do |csv|
            @response.parsed_response.split(/\r\n/).each do |row|
              csv << row.split(/\t/)
            end
          end
        end
        @response
      end

      def has_next?
        not @next[:token].nil?
      end
      alias :has_next :has_next?

      def next
        self.send(@next[:action], :next_token => @next[:token]) unless @next[:token].nil?
      end

      def inspect
        "#<#{self.class.to_s}:#{object_id}>"
      end

    end

  end
end