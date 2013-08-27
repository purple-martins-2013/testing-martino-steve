require 'rspec'

require_relative 'cookie'

describe Cookie do

  let(:type)   { "peanut butt" }
  let(:cookie) { Cookie.new(type) }

  describe "#initialize" do

    context "with valid input" do

      it "creates a new Cookie of the specified type" do
        expect(cookie.type).to eq type
      end

    end

    context "with invalid input" do

      it "throws an argument error when not given a type argument" do
        expect { Cookie.new }.to raise_error(ArgumentError)
      end

    end

  end

  describe "#type" do
    
    it "returns the type of the cookie for varioius types" do
      type = ['chocholate chrunch', 'oatmeal raisin', 'pasta mania', 'macademia madness'].sample
      new_cookie = Cookie.new(type)
      expect(new_cookie.type).to eq type
    end

  end

  describe "#bake!" do
    it "requires an integer time argument" do
      expect { cookie.bake!('10 minutes') }.to raise_error TypeError
      expect { cookie.bake!() }.to raise_error ArgumentError
    end

    it "returns the cookie object" do
      bake_return = cookie.bake!(10)
      expect(bake_return).to be_a Cookie
      expect(bake_return).to eq cookie
    end

    it "changes the status of the cookie when given enough time" do
      expect { cookie.bake!(10) }.to change(cookie, :status)
    end
  end

  describe "#status" do
    it "returns the cookie's current status" do
      expect(cookie.status).to eq :doughy
    end

    context "when unbaked" do
      
      it "is `:doughy`"  do
        expect(cookie.status).to eq :doughy
      end

    end

    context "when baked for less than 7 minutes" do

      before { cookie.bake! 6 }
      
      it "is `:doughy`" do
        expect(cookie.status).to eq :doughy
      end

    end  

    context "when baked for at least 7 but less than 10 minutes" do
      
      before { cookie.bake! 8 }
      
      it "is `:almost_ready`" do
        expect(cookie.status).to eq :almost_ready
        cookie.bake! 1
        expect(cookie.status).to eq :almost_ready
      end


    end

    context "when baked for at least 10 but less than 12 minutes" do
      
      before { cookie.bake! 11 }
      
      it "is `:ready`" do  
        expect(cookie.status).to eq :ready
      end

    end

    context "when baked for at least 12 minutes" do
    
      before { cookie.bake! 12 }

      it "is `:burned`" do
        expect(cookie.status).to eq :burned
      end

    end

  end
end
