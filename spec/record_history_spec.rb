require 'spec_helper'

describe RecordHistoryModel do

  let (:author) { Factory.create(:user) }
  before { ::RecordHistory.author = author }

  context "validations" do
    it { should validate_presence_of(:item_type) }
    it { should validate_presence_of(:item_id) }
    describe "when no attribute name is present" do
      it { should_not validate_presence_of(:old_value_dump) }
      it { should_not validate_presence_of(:new_value_dump) }
    end
    describe "when an attribute name is present" do
      before { subject.attr_name = "stuff" }
      it { should validate_presence_of(:old_value_dump) }
      it { should validate_presence_of(:new_value_dump) }
    end
  end

  context "associations" do
    let (:some_data) { Factory.create(:some_data) }
    let (:first_history_from_some_data) { some_data.record_history.first }

    it "creates a history when some data is created" do
      some_data.class.name == first_history_from_some_data.item_type.should
      some_data.id.should == first_history_from_some_data.item.id
    end

    it "uses the current author on the first history" do
      first_history_from_some_data.author.should == author
      author.written_history.first.should == first_history_from_some_data
    end
  end
end
