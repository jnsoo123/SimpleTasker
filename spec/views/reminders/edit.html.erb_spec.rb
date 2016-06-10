require 'rails_helper'

RSpec.describe "reminders/edit", type: :view do
  before(:each) do
    @reminder = assign(:reminder, Reminder.create!(
      :title => "MyString",
      :note => "MyText"
    ))
  end

  it "renders the edit reminder form" do
    render

    assert_select "form[action=?][method=?]", reminder_path(@reminder), "post" do

      assert_select "input#reminder_title[name=?]", "reminder[title]"

      assert_select "textarea#reminder_note[name=?]", "reminder[note]"
    end
  end
end
