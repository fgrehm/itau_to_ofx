require 'optparse'

module ItauToOfx
  class CLI
    include Scraper
  
    def self.execute(stdout, arguments=[])
      parser = OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /,'')
          Converte um extrato do Itau para OFX

          Utilizacao: #{File.basename($0)} arquivo1[ arquivo2[...]]
        BANNER
        opts.separator ""
        opts.on("-h", "--help",
                "Exibe esta mensagem.") { stdout.puts opts; exit }
        opts.parse!(arguments)
      end
      
      stdout.puts
      run(stdout)
      stdout.puts
    end
    
    protected
    
    def self.run(stdout)
      if ARGV.size == 0
        try_clipboard(stdout)
      else
        parse_files(stdout)
      end
    end
    
    def self.parse_files(stdout)
      ARGV.each do|file|
        f = nil
        
        begin
          f = File.open(file)
        rescue Errno::ENOENT 
          stdout.print "Arquivo nao encontrado: ", $!, "\n" 
          next
        end
        
        line = f.gets
        f.rewind
                  
        stdout.print "  Analisando conteudo do arquivo '#{file}'..."
        transactions = if Savings.valid?(line)
            stdout.puts " (poupanca)"
            savings.parse(f)
          elsif CreditCard.valid?(line)
            stdout.puts " (credito)"
            credit_card.parse(f)
          end
        f.close
        
        unless transactions
          stdout.puts "\n    O arquivo '#{file}' possui um formato invalido!"
          next
        end
        
        stdout.print "    Convertendo arquivo '#{file}' para '#{file}.ofx'..."
        File.open("#{file}.ofx", 'w') do |f|
          generator.write(transactions, f)
        end
        stdout.puts "  OK!"
      end
    end
    
    def self.try_clipboard(stdout)
      gem 'clipboard'
      require 'clipboard'
    
      contents = Clipboard.paste('clipboard').strip
      clipboard_empty = (contents == '')

      transactions = nil

      unless clipboard_empty
        line = contents.lines.first

        stdout.print '  Analisando conteudo da area de transferencia...'
        transactions = if Savings.valid?(line)
            stdout.puts " (poupanca)"
            savings.parse(contents)
          elsif CreditCard.valid?(line)
            stdout.puts " (credito)"
            credit_card.parse(contents)
          end
      end
      
      unless transactions
        stdout.puts "\n    Nao foi possivel gerar o extrato!"
        return
      end
      
      stdout.print "  Convertendo conteudo da area de transferencia para 'clipboard.ofx'..."
      File.open("clipboard.ofx", 'w') do |f|
        generator.write(transactions, f)
      end
      stdout.puts "  OK!"
    end
   
    def self.generator
      @generator ||= Generator.new
    end 
   
    def self.savings
      @savings ||= Savings.new
    end 
    
    def self.credit_card
      @credit_card ||= CreditCard.new
    end 
  end
end
