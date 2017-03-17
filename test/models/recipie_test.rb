require 'test_helper'

class RecipieTest < ActiveSupport::TestCase
  def setup
    @recipie = Recipie.new(name: "Vegies", description: "Great Vegie Recipie")
  end

  test "recipie should be valid" do
    assert @recipie.valid?
  end
  
  test "name should be present" do
    @recipie.name = " "

    assert_not @recipie.valid?
  end

  test "description should be present" do
    @recipie.description = ""

    assert_not @recipie.valid?
  end

  test "description should have minimum 5 chars" do
    @recipie.description = "a" *3

    assert_not @recipie.valid?
  end

  test "description should have maximum 500 chars" do
    @recipie.description = "a" *501

    assert_not @recipie.valid?
  end
end
