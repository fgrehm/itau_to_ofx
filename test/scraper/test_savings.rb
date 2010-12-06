require 'helper'

module ItauToOfx::Scraper
  class TestSavings < Test::Unit::TestCase
    include ItauToOfx::Transaction
  
    context 'When validating a line' do
      should 'return true for a transaction' do
        assert Savings.valid?("  26  	  	  REMUNER BASICA-ANIV.26 	0,25   	\n")
      end
      
      should 'return true for a previous balance line' do
        assert Savings.valid?("  18  	  	  SALDO ANTERIOR 	338,77   	 \n")
      end
      
      should 'return true for a balance line' do
        assert Savings.valid?("  26  	  	  S A L D O 	242,56   	 \n")
      end
      
      should 'return false for a credit card line' do
        assert ! Savings.valid?("  01/10 - Some store 	0,00   	98,00  \n")
      end
    end
  
    context 'An Savings instance' do
      setup do
        @scraper = Savings.new
      end
      
      context 'parsing a statement line' do      
        setup do
          parse_line("  26  	  	  REMUNER BASICA-ANIV.26 	0,25   	\n")
        end
      
        should 'return a Transaction instance' do
          assert_kind_of ItauToOfx::Transaction::Base, @transaction
        end
        
        should 'extract transaction date' do
          assert_instance_of Date, @transaction.date
        end
      
        should "identify transaction's day" do
          assert_equal 26, @transaction.date.day
        end
        
        should "set transaction's month to current when day is lower than today" do          
          Time.warp(Date.parse('2010-01-25')) do
            parse_line("  23  	  	  REMUNER BASICA-ANIV.26 	0,25   	\n")
          end
          
          assert_equal 1, @transaction.date.month
        end
        
        should "set transaction's month to past when day is higher than today" do
          Time.warp(Date.parse('2010-01-25')) do
            parse_line("  26  	  	  REMUNER BASICA-ANIV.26 	0,25   	\n")
          end
          
          assert_equal 12, @transaction.date.month
        end
        
        should "set transaction's amount" do
          parse_line("  26  	  	  REMUNER BASICA-ANIV.26 	3.589,25   	\n")
          
          assert_equal 3589.25, @transaction.amount
        end
        
        should "set transaction's memo" do
          parse_line("  26  	  	  REMUNER BASICA-ANIV.26 	0,25   	\n")
          
          assert_equal 'REMUNER BASICA-ANIV.26', @transaction.memo
        end
      end
      
      context 'parsing credit statement line' do
        setup do
          parse_line("  26  	  	  REMUNER BASICA-ANIV.26 	0,25   	\n")
        end
      
        should 'return a Transaction::Credit instance' do
          assert_instance_of Credit, @transaction
        end
      end
      
      context 'parsing debit statement line' do
        setup do
          parse_line("  26  	  	  REMUNER BASICA-ANIV.26 	0,25-   	\n")
        end
      
        should 'return a Transaction::Debit instance' do
          assert_instance_of Debit, @transaction
        end
      end
      
      context 'parsing balance statement line' do      
        should 'return nil for current balance' do
          parse_line("  26  	  	  S A L D O 	242,56   	 \n")
          
          assert_nil @transaction
        end
        
        should 'return nil for previous balance' do
          parse_line("  18  	  	  SALDO ANTERIOR 	338,77   	 \n")
        
          assert_nil @transaction
        end
      end

      context 'parsing a sample statement' do
        setup do
          @transactions = @scraper.parse(full_fixture_path('sample_savings.txt'))
        end
        
        should 'return 9 transactions' do
          assert_equal 9, @transactions.size
        end
        
        should 'return Transaction instances' do
          assert_kind_of ItauToOfx::Transaction::Base, @transactions.first
        end
      end
    end
  end
end
