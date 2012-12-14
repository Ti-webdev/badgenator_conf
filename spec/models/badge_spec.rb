require 'spec_helper'

describe Badge do

  describe "database schema" do
  	it { should belong_to :badge_set }
    it { should have_db_column(:name).of_type(:string).with_options(:null => false) }
    it { should have_db_column(:surname).of_type(:string) }
    it { should have_db_column(:company).of_type(:string) }
    it { should have_db_column(:profession).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }

    it { should have_db_column(:badge_set_id).of_type(:integer) }
    it { should have_db_index(:badge_set_id) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:company) }
    it { should validate_presence_of(:badge_set_id) }
    it { should ensure_length_of(:name).is_at_least(2).is_at_most(30) }
    it { should ensure_length_of(:company).is_at_least(3).is_at_most(30) }
    it { should ensure_length_of(:surname).is_at_least(2).is_at_most(30) }
    it { should ensure_length_of(:profession).is_at_least(3).is_at_most(30) }
  end

  it "has a valid factory" do
    FactoryGirl.create(:badge).should be_valid
  end

end
