require 'rails_helper'

RSpec.describe "reminders/index", type: :view do
  before(:each) do
    assign(:reminders, [
      Reminder.create!(
        :title => "Title",
        :note => "MyText"
      ),
      Reminder.create!(
        :title => "Title",
        :note => "MyText"
      )
    ])
  end

  it "renders a list of reminders" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
