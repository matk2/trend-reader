require 'rails_helper'

RSpec.describe "trends/new", type: :view do
  before(:each) do
    assign(:trend, Trend.new(
      :kind => "MyString",
      :rate_id => 1
    ))
  end

  it "renders new trend form" do
    render

    assert_select "form[action=?][method=?]", trends_path, "post" do

      assert_select "input#trend_kind[name=?]", "trend[kind]"

      assert_select "input#trend_rate_id[name=?]", "trend[rate_id]"
    end
  end
end
