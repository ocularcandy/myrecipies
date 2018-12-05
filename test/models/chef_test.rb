require 'test_helper'

class ChefTest < ActiveSupport::TestCase
    def setup
        @chef = Chef.new(chefname: "Amber", email: "amber@ocularcandy.biz",
                         password: "password", password_confirmation: "password")
    end

    test "chef should be valid" do
        assert @chef.valid?
    end

    test "chefname should be present" do
        @chef.chefname = ""

        assert_not @chef.valid?
    end

    test "chefname should have maximum 30 chars" do
        @chef.chefname = "a" *31

        assert_not @chef.valid?
    end

    test "email should be present" do
        @chef.email = ""

        assert_not @chef.valid?
    end

    test "email should have maximum 250 chars" do
        @chef.email = "a" *245 + "@example.com"

        assert_not @chef.valid?
    end

    test "email should have valid format" do
        valids = %w[user@example.com test@test.com f.irst@yahoo.ca john+doe@co.uk.org]
        valids.each do |valid|
            @chef.email = valid

            assert @chef.valid?, "#{valids.inspect} should be valid"
        end
    end

    test "email should reject invalid email formats" do
        invalids = %w[user@example test@test,com f.irst@yahoo. john+doe.com]
        invalids.each do |invalid|
            @chef.email = invalid

            assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
        end
    end

    test "email should be unique and case insensitive" do
        duplicate_chef = @chef.dup
        duplicate_chef.email = @chef.email.upcase
        @chef.save

        assert_not duplicate_chef.valid?
    end

    test "email should be lowercase before saving to db" do
        mixed = "JohN@EmaIL.com"
        @chef.email = mixed
        @chef.save

        assert_equal mixed.downcase, @chef.reload.email
    end

    test "password should be present" do
        @chef.password = @chef.password_confirmation = " "
        assert_not @chef.valid?
    end

    test "password should have at least 8 characters" do
        @chef.password = @chef.password_confirmation = "x" *4
        assert_not @chef.valid?

    end
end
