module ItauToOfx::Scraper
  class Base
    include ItauToOfx::Transaction
  
    def parse(buffer)
      transactions = []
      
      if File.exists?(buffer)
        File.open(buffer) do |f|
          while line = f.gets
            if t = parse_line(line)
              transactions << t
            end
          end
        end
      else
        buffer.each_line do |line|
          if t = parse_line(line)
            transactions << t
          end
        end
      end
      
      transactions
    end
  
    def parse_line(line)
      raise 'Not implemented'
    end
  end
end
