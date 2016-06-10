require 'rails_helper'

RSpec.describe "reminders/new", type: :view do
  before(:each) do
    assign(:reminder, Reminder.new(
      :title => "MyString",
      :note => "MyText"
    ))
  end

  it "renders new reminder form" do
    render

    assert_select "form[action=?][method=?]", reminders_path, "post" do

      assert_select "input#reminder_title[name=?]", "reminder[title]"

      assert_select "textarea#reminder_note[name=?]", "reminder[note]"
    end
  end
end
