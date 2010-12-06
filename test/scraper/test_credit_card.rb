require 'helper'

module ItauToOfx::Scraper
  class TestCreditCard < Test::Unit::TestCase
    include ItauToOfx::Transaction
  
    context 'When validating a line' do
      should 'return true for a transaction' do
        assert CreditCard.valid?("  01/10 - Some store 	0,00   	98,00  \n")
      end
      
      should 'return false for a savings line' do
        assert ! CreditCard.valid?("  26  	  	  REMUNER BASICA-ANIV.26 	0,25   	\n")
      end
    end
  
    context 'An CreditCard instance' do
      setup do
        @scraper = CreditCard.new
      end
    
      context 'parsing a statement line' do      
        setup do
          parse_line("  01/10 - Some store 	0,00   	98,00  \n")
        end
      
        should 'return a Transaction instance' do
          assert_kind_of ItauToOfx::Transaction::Base, @transaction
        end
        
        should 'extract transaction date' do
          assert_instance_of Date, @transaction.date
        end
      
        should "identify transaction's day" do
          assert_equal 1, @transaction.date.day
        end
        
        should "identify transaction's month" do
          assert_equal 10, @transaction.date.month
        end
        
        should "set transactions's year to current year" do
          assert_equal Date.today.year, @transaction.date.year 
        end
        
        should "extract transactions's memo" do
          assert_equal "Some store", @transaction.memo
        end
      end
      
      context 'parsing debit statement line' do
        setup do
          parse_line("  01/10 - Some store 	0,00   	98,58  \n")
        end
      
        should 'return a Transaction::Debit instance' do
          assert_instance_of Debit, @transaction
        end
        
        should "extract transactions's amount" do
          assert_equal 98.58, @transaction.amount
        end
      end
      
      context 'parsing installment payment' do
        should "add payment info to transaction's memo" do
          parse_line("  17/12 - Store 02/03 	0,00   	87,40")
          assert_equal 'Store - Parcela 2 de 3', @transaction.memo
        end
        
        should "adjust transaction's month based on occurrence" do
          parse_line("  17/02 - Store 02/03 	0,00   	87,40")
        
          expected = Date.parse("#{Date.today.year}-02-17").advance(:months => 1)
          assert_equal expected, @transaction.date
        end
      end
      
      context 'parsing credit statement line' do
        setup do
          parse_line("  01/10 - Some store 	5.999,58   	0,00  \n")
        end
      
        should 'return a Transaction::Credit instance' do
          assert_instance_of Credit, @transaction
        end
        
        should "extract transactions's amount" do
          assert_equal 5999.58, @transaction.amount
        end
      end
      
      context 'parsing a sample statement' do
        setup do
          @transactions = @scraper.parse(full_fixture_path('sample.txt'))
        end
        
        should 'return 6 transactions' do
          assert_equal 6, @transactions.size
        end
        
        should 'return Transaction instances' do
          assert_kind_of ItauToOfx::Transaction::Base, @transactions.first
        end
      end
    end
  end
end
