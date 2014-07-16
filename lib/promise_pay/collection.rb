module PromisePay
  class Collection
    attr_reader :collection_class

    def initialize(collection_class)
      @collection_class = collection_class
    end

    def parse
      p collection_class.new
      tmp = collection_class.new.fetch_all
      p tmp
    end
  end
end
