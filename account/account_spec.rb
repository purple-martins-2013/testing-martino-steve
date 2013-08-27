require "rspec"

require_relative "account"

describe Account do
  
  let(:account) { Account.new('1000000000', 999_999) }

  describe "#initialize" do

    describe 'when given correct information' do


      it 'should create a new account with valid info' do
        lambda { account }.should_not raise_error
      end


      it 'should have a zero balance when no balance is provided' do
        new_account = Account.new('1000000000')
        new_account.transactions.should == [0]
      end

    end

    describe 'when given incorrect information' do 

      it 'should raise an InvalidAccountNumberError with invalid account' do
        expect { Account.new('111', 999) }.to raise_error InvalidAccountNumberError
      end
    
    end
  
  end 


  describe "#transactions" do

    it 'should have a first transaction equal to starting balance' do
      expect(account.transactions).to eq [999_999]
    end

  end

  describe "#balance" do

    it 'should return the transaction amount with one transaction' do
      expect(account.balance).to eq 999_999 
    end

    it 'should return the sum of the transactions with two transactions' do
      account.deposit!(1)
      expect(account.balance).to eq 1_000_000
    end

  end

  describe "#account_number" do

    it 'should only show the last four digits' do
      expect(account.account_number).to match /^\*{6}\d{4}$/
    end

  end

  describe "deposit!" do

    it 'should increment the transactions by 1' do
      expect{ account.deposit!(1) }.to change { account.transactions.count }.by(1)
    end

    it 'should return the balance' do
      expect(account.deposit!(1)).to eq account.balance
    end

    it 'should raise a NegativeDepositError when deposit is negative' do 
      expect { account.deposit!(-1) }.to raise_error NegativeDepositError
    end

  end

  describe "#withdraw!" do

    it 'should increment the transactions by 1' do
      expect{ account.withdraw!(-1) }.to change { account.transactions.count }.by(1)
    end

    it 'should return the balance' do 
      expect(account.balance).to eq account.balance
    end

    it 'should raise an OverdraftError when there are insufficient funds' do
      expect { account.withdraw!(1_100_000) }.to raise_error OverdraftError
    end

    it 'should still work if withdraw amount is written as positive' do
      expect { account.withdraw!(1) }.to change { account.transactions.count }.by(1)
      expect { account.withdraw!(1) }.to change { account.balance }.by(-1)
    end

  end
  
end
