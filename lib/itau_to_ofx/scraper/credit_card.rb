module ItauToOfx::Scraper
  class CreditCard < Base
    def parse_line(line)
      match = STMT_REGEX.match(line.strip)

      t = transaction_type(match).new
      set_transaction_amount(t, match)
      t.date = Date.parse("#{Date.today.year}-#{match[stmt_indexes[:month]]}-#{match[stmt_indexes[:day]]}")
      occurrence, t.memo = build_memo(match[stmt_indexes[:memo]].strip)
      t.date = t.date.advance(:months => occurrence)
      t
    end
    
    def self.valid?(line)
      line.strip =~ STMT_REGEX
    end
    
    protected
    
    STMT_REGEX = /^(\d\d)\/(\d\d)\s+-\s+(.*)\s+([\d+\.]*\d+,\d{2})\s*([\d+\.]*\d+,\d{2})$/
    
    def transaction_type(match)
      if match[stmt_indexes[:debit]] != '0,00'
        Debit
      else
        Credit
      end
    end
    
    def build_memo(memo)
      return [0, memo] unless memo =~ /(.*)(\d{2})\/(\d{2})$/
      
      occurrence = $2.to_i
      total = $3.to_i
      memo = "#{$1.strip} - Parcela #{occurrence} de #{total}"
      
      [occurrence-1, memo]
    end
    
    def set_transaction_amount(transaction, match)
      transaction.amount = case transaction
        when Debit
          match[stmt_indexes[:debit]]
        when Credit
          match[stmt_indexes[:credit]]
        end.sub('.', '').sub(',', '.').to_f
    end
    
    def stmt_indexes
      @indexes ||= {
        :day => 1,
        :month => 2,
        :memo => 3,
        :credit => 4,
        :debit => 5
      }
    end
  end
end
