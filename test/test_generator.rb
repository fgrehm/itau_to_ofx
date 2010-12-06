require 'helper'

module ItauToOfx
  class TestGenerator < Test::Unit::TestCase
    include Transaction
  
    def assert_buffer_identical_to_fixture(fixture)
      file = full_fixture_path(fixture)
      assert_equal File.new(file).read, @buffer, "Output is not identical to #{file}"
    end
  
    context 'An Generator instance' do    
      setup do
        @buffer = ""
        @generator = Generator.new
      end
      
      should 'write the basic structure' do 
        Time.warp(Date.parse('2010-11-08')) do
          @generator.write([], @buffer)
        end
        
        assert_buffer_identical_to_fixture('basic_structure.ofx')
      end
      
      should 'write a credit transaction' do
        transaction = Credit.new(:date => Date.parse('2010-10-25'), :amount => 400, :memo => 'Paypal money')

        @generator.write_transaction(transaction, @buffer)
        
        assert_buffer_identical_to_fixture('ofx_credit_transaction')
      end
      
      should 'write a debit transaction' do
        transaction = Debit.new(:date => Date.parse('2010-10-25'), :amount => 400, :memo => 'Paypal money')

        @generator.write_transaction(transaction, @buffer)
        
        assert_buffer_identical_to_fixture('ofx_debit_transaction')
      end
      
      should 'write some transactions' do
        transactions = [
          Debit.new(:date => Date.parse('2010-10-25'), :amount => 400, :memo => 'Paypal money'),
          Credit.new(:date => Date.parse('2010-10-26'), :amount => 300, :memo => 'Adsense money')
        ]

        Time.warp(Date.parse('2010-11-08')) do
          @generator.write(transactions, @buffer)
        end
        
        assert_buffer_identical_to_fixture('some_transactions.ofx')
      end
      
      should 'write current date as DTSERVER and DTASOF' do
        Time.warp(Date.parse('1900-01-01')) do
          @generator.write([], @buffer)
        end
        
        assert_buffer_identical_to_fixture('dtserver_and_dtasof.ofx')
      end
      
      should 'write first transaction date as DTSTART and last transaction date as DTEND' do
        transactions = [
          Debit.new(:date => Date.parse('2010-10-26'), :amount => 400, :memo => 'Paypal money'),
          Debit.new(:date => Date.parse('2010-10-27'), :amount => 400, :memo => 'Paypal money')
        ]
      
        Time.warp(Date.parse('2010-11-08')) do
          @generator.write(transactions, @buffer)
        end
        
        assert_buffer_identical_to_fixture('dtstart_and_dtend.ofx')
      end
    end
  end
end
