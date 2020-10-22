require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do 
    it "has an email" do 
      user = FactoryBot.build :user, email: nil 
      user.valid? 
      expect(user.errors).to have_key(:email)
    end 

    it "has first_name" do 
      user = FactoryBot.build :user, first_name: nil 
      user.valid? 
      expect(user.errors).to have_key(:first_name)
    end
    
    it "has last_name" do 
      user = FactoryBot.build :user, last_name: nil 
      user.valid? 
      expect(user.errors).to have_key(:last_name)
    end

    it "requires a password" do 
      user = FactoryBot.build :user, password: nil 
      user.valid? 
      expect(user.errors).to have_key(:password)
    end

    it "has a unique email" do 
      user = FactoryBot.create :user, email: "hano@codecore.ca"
      user_2 = FactoryBot.build :user, email: "hano@codecore.ca"
      user_2.valid? 
      expect(user_2.errors).to have_key(:email)
    end

  end

  describe ".full_name" do 
    it "returns the concatenated version of the first and last name" do 
      user = FactoryBot.create(:user, first_name: "michael", last_name: "owen" )
      expect(user.full_name).to eq('Michael Owen')
    end 
  end
end
