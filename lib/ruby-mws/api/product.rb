module MWS
  module API
    class Product < Base
      
      def_request [:get_matching_product_for_id],
        :verb => :get,
        :uri => '/Products/2011-10-01',
        :version => '2011-10-01',
        :id_type => "ASIN",
        :lists => {
          :id_list => "IdList.Id"
        }

      def_request [:get_matching_product],
        :verb => :get,
        :uri => '/Products/2011-10-01',
        :version => '2011-10-01',
        :lists => {
          :id_list => "IdList.Id"
        }

      def_request [:get_product_categories_for_sku],
        :verb => :get,
        :action => 'GetProductCategoriesForSKU',
        :uri => '/Products/2011-10-01',
        :version => '2011-10-01'

      def_request [:get_product_categories_for_asin],
        :verb => :get,
        :action => 'GetProductCategoriesForASIN',
        :uri => '/Products/2011-10-01',
        :version => '2011-10-01'

    end
  end
end