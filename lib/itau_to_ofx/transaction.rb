module ItauToOfx
  module Transaction
  end
end

module ItauToOfx
  module Transaction
    class Base
      attr_accessor :date,
                    :memo,
                    :amount
                    
      def initialize(args={})
        @date = args[:date]
        @memo = args[:memo]
        @amount = args[:amount]
      end
    end
    
    class Debit < Base; end
      
    class Credit < Base; end
  end
end
