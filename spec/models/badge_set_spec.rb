require 'spec_helper'

describe BadgeSet do

  describe "database schema" do
    it { should have_many(:badges) }
    it { should have_db_column(:name).of_type(:string).with_options(:null => false) }
    it { should have_db_column(:image).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_least(2).is_at_most(50) }
  end

  it "has a valid factory" do
    FactoryGirl.build(:badge_set).should be_valid
  end

  it "is invalid without a name and source file" do
    FactoryGirl.build(:badge_set, name: nil, source: nil).should_not be_valid
  end

  it "should generate badge_set name using source file name" do
    badge_set = FactoryGirl.create(:badge_set, :source, name: nil)
    badge_set.name.should == 'badges'
  end

  it "should not accept image with invalid extension" do
    FactoryGirl.build(:badge_set, 
      image: Rack::Test::UploadedFile.new('spec/fixtures/png.txt', 'text/plain')
    ).should_not be_valid
  end

  it "should not accept image with invalid mime type" do
    FactoryGirl.build(:badge_set, 
      image: Rack::Test::UploadedFile.new('spec/fixtures/txt.jpg', 'image/jpeg')
    ).should_not be_valid
  end

  describe "#source" do
    it "should not create any badges if source is not specified" do
      badge_set = FactoryGirl.create(:badge_set)
      badge_set.badges.count.should == 0
    end

    context "valid file" do
      let(:badge_set) { FactoryGirl.create :badge_set, :image, :source }
      subject { badge_set }

      its('badges.count') { should == 10 }
      its('badges.first.name') { should == 'name0' }
      its('badges.first.surname') { should == 'surname0' }
      its('badges.first.company') { should == 'company0' }
      its('badges.first.profession') { should == 'profession0' }
    end

    context "invalid file" do
      let(:badge_set) { FactoryGirl.build(:badge_set, source: Rack::Test::UploadedFile.new('spec/fixtures/logo.png', 'image/png')) }
      subject { badge_set }

      it "should not be saved" do
        expect { subject.save }.to_not change(BadgeSet, :count)
      end

      it "should not create badges" do
        expect { subject.save }.to_not change(Badge, :count)
      end
    
      it "should be a new record" do
        subject.save
        subject.new_record?.should be_true
      end

      it "should not be valid" do
        subject.save
        subject.should_not be_valid
      end
      
      it "should have source errors" do
        subject.save
        subject.should have(1).error_on(:source)
      end
    end
  end

end
