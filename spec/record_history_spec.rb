require 'spec_helper'

require 'factories/record_history_models'
require 'factories/users'
require 'factories/some_datas'
require 'shoulda-matchers'

describe RecordHistoryModel do
  context "validations" do
    before :each do
      @hist = Factory.create(:record_history_model)
    end
    it "presence" do
      [:item_type, :item_id, :old_value_dump, :new_value_dump].each do |attr|
        @hist.send("#{attr}=", nil)
        @hist.should_not be_valid
        @hist.errors.size.should == 1
        @hist.errors.get(attr).should == ["can't be blank"]
        @hist.send("#{attr}=", Factory.build(:record_history_model).send(attr ))
        @hist.should be_valid
      end
    end
  end

  context "associations" do
    before :each do
      @hist = Factory.create(:record_history_model)
    end

    it "item" do
      item = @hist.item
      item.class.name.should == @hist.item_type
      item.id.should == @hist.item.id

      item.record_history.first.should == @hist
    end

    it "author" do
      author = @hist.author
      author.class.name.should == @hist.author_type
      author.id.should == @hist.author_id

      author.written_history.first.class.name.should == "RecordHistoryModel"
    end
  end
end
