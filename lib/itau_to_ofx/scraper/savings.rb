module ItauToOfx::Scraper
  class Savings < Base
    def parse_line(line)
      line = line.strip
      
      return if line =~ BALANCE_REGEX
    
      match = STMT_REGEX.match(line)
    
      t = transaction_type(match).new
      set_transaction_amount(t, match[stmt_indexes[:amount]])
      set_transaction_date(t, match[stmt_indexes[:day]].to_i)
      t.memo = match[stmt_indexes[:memo]].strip
      t
    end
    
    def self.valid?(line)
      line.strip =~ STMT_REGEX or line.strip =~ BALANCE_REGEX
    end
    
    protected 
    
    STMT_REGEX = /^(\d{2})\s+(.*)\s+([\d+\.]*\d+,\d{2}(?:|-))$/
    
    BALANCE_REGEX = /^(\d{2})\s+(S A L D O|SALDO ANTERIOR)\s+([\d+\.]*\d+,\d{2}(?:|-))$/
    
    def transaction_type(match)
      if match[stmt_indexes[:amount]] =~ /-$/
        Debit
      else
        Credit
      end
    end
    
    def set_transaction_amount(transaction, amount)
      transaction.amount = amount.sub('-', '').sub('.', '').sub(',', '.').to_f
    end
    
    def set_transaction_date(transaction, day)
      transaction.date = Date.parse("#{Date.today.year}-#{Date.today.month}-#{day}")
      
      if (day > Date.today.day)
        transaction.date = transaction.date.advance(:months => -1)
      end
    end
    
    def stmt_indexes
      @indexes ||= {
        :day => 1,
        :memo => 2,
        :amount => 3
      }
    end
  end
end
