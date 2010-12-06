require 'helper'

module ItauToOfx
  class TestTransaction < Test::Unit::TestCase
    context 'Transaction instances' do
      setup do
        @transaction = Transaction::Base.new
      end
      
      should 'allow setting a date' do
        assert @transaction.respond_to?(:date=)
      end
      
      should 'allow getting a date' do
        @transaction.date = Date.today
        assert_equal Date.today, @transaction.date
      end
      
      should 'allow setting a memo' do
        assert @transaction.respond_to?(:memo=)
      end
      
      should 'allow getting a memo' do
        @transaction.memo = 'memo'
        assert_equal 'memo', @transaction.memo
      end
      
      should 'allow setting an amount' do
        assert @transaction.respond_to?(:amount=)
      end
      
      should 'allow getting an amount' do
        @transaction.amount = 1.58
        assert_equal 1.58, @transaction.amount
      end
    end
  end
end
