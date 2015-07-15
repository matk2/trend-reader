require 'rails_helper'

RSpec.describe "trends/edit", type: :view do
  before(:each) do
    @trend = assign(:trend, Trend.create!(
      :kind => "MyString",
      :rate_id => 1
    ))
  end

  it "renders the edit trend form" do
    render

    assert_select "form[action=?][method=?]", trend_path(@trend), "post" do

      assert_select "input#trend_kind[name=?]", "trend[kind]"

      assert_select "input#trend_rate_id[name=?]", "trend[rate_id]"
    end
  end
end
