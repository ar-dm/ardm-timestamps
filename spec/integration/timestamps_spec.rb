require 'pathname'
require Pathname(__FILE__).dirname.expand_path.parent + 'spec_helper'

if HAS_SQLITE3
  describe 'DataMapper::Timestamp' do
    before :all do
      class GreenSmoothie
        include DataMapper::Resource

        property :id, Integer, :serial => true
        property :name, String
        property :created_at, DateTime
        property :created_on, Date
        property :updated_at, DateTime
        property :updated_on, Date

        auto_migrate!(:sqlite3)
      end
    end

    after do
     repository(:sqlite3).adapter.execute('DELETE from green_smoothies');
    end

    it "should set the created_at/on fields on creation" do
      repository(:sqlite3) do
        green_smoothie = GreenSmoothie.new(:name => 'Banana')
        green_smoothie.created_at.should be_nil
        green_smoothie.created_on.should be_nil
        green_smoothie.save
        green_smoothie.created_at.should be_a_kind_of(DateTime)
        green_smoothie.created_on.should be_a_kind_of(Date)
      end
    end

    it "should not alter the create_at/on fields on model updates" do
      repository(:sqlite3) do
        green_smoothie = GreenSmoothie.new(:id => 2, :name => 'Berry')
        green_smoothie.created_at.should be_nil
        green_smoothie.created_on.should be_nil
        green_smoothie.save
        original_created_at = green_smoothie.created_at
        original_created_on = green_smoothie.created_on
        green_smoothie.name = 'Strawberry'
        green_smoothie.save
        green_smoothie.created_at.should eql(original_created_at)
        green_smoothie.created_on.should eql(original_created_on)
      end
    end

    it "should set the updated_at/on fields on creation and on update" do
      repository(:sqlite3) do
        green_smoothie = GreenSmoothie.new(:name => 'Mango')
        green_smoothie.updated_at.should be_nil
        green_smoothie.updated_on.should be_nil
        green_smoothie.save
        green_smoothie.updated_at.should be_a_kind_of(DateTime)
        green_smoothie.updated_on.should be_a_kind_of(Date)
        original_updated_at = green_smoothie.updated_at
        original_updated_on = green_smoothie.updated_on
        sleep 1
        tomorrow = Date.today + 1
        Date.should_receive(:today).and_return(tomorrow)
        green_smoothie.name = 'Cranberry Mango'
        green_smoothie.save
        green_smoothie.updated_at.should_not eql(original_updated_at)
        green_smoothie.updated_on.should_not eql(original_updated_on)
      end
    end
  end
end
