require File.join(File.dirname(__FILE__), '..', 'test_helper')
require 'action_mailer'
require 'mocha'

class ActionMailerTest < Test::Unit::TestCase # :nodoc:

  context "given delivered emails" do
    setup do
      email1 = stub(:subject => "one", :to => ["none1@email.com"])
      email2 = stub(:subject => "two", :to => ["none2@email.com"])
      ActionMailer::Base.stubs(:deliveries).returns([email1, email2])
    end

    should "have sent an email" do
      assert_sent_email

      assert_raises(Test::Unit::AssertionFailedError) do
        assert_did_not_send_email
      end
    end

    should "find email one" do
      assert_sent_email do |e|
        e.subject =~ /one/
      end
    end

    should "not find an email that doesn't exist" do
      assert_raises(Test::Unit::AssertionFailedError) do
        assert_sent_email do |e|
          e.subject =~ /whatever/
        end
      end
    end
  end

  context "when there are no emails" do
    setup do
      ActionMailer::Base.stubs(:deliveries).returns([])
    end

    should "not have sent an email" do
      assert_did_not_send_email

      assert_raises(Test::Unit::AssertionFailedError) do
        assert_sent_email
      end
    end
  end

  context "assert_good_value" do
    should "validate a good email address" do
      assert_good_value User.new, :email, "good@example.com"
    end

    should "validate a good SSN with a custom message" do
      assert_good_value User.new, :ssn, "xxxxxxxxx", /length/
    end

    should "fail to validate a bad email address" do
      assert_raises Test::Unit::AssertionFailedError do
        assert_good_value User.new, :email, "bad"
      end
    end

    should "fail to validate a bad SSN that is too short" do
      assert_raises Test::Unit::AssertionFailedError do
        assert_good_value User.new, :ssn, "x", /length/
      end
    end

    should "accept a class as the first argument" do
      assert_good_value User, :email, "good@example.com"
    end

    context "with an instance variable" do
      setup do
        @product = Product.new(:tangible => true)
      end

      should "use that instance variable" do
        assert_good_value Product, :price, "9999", /included/
      end
    end
  end

  context "assert_bad_value" do
    should "invalidate a bad email address" do
      assert_bad_value User.new, :email, "bad"
    end

    should "invalidate a bad SSN with a custom message" do
      assert_bad_value User.new, :ssn, "x", /length/
    end

    should "fail to invalidate a good email address" do
      assert_raises Test::Unit::AssertionFailedError do
        assert_bad_value User.new, :email, "good@example.com"
      end
    end

    should "fail to invalidate a good SSN" do
      assert_raises Test::Unit::AssertionFailedError do
        assert_bad_value User.new, :ssn, "xxxxxxxxx", /length/
      end
    end

    should "accept a class as the first argument" do
      assert_bad_value User, :email, "bad"
    end

    context "with an instance variable" do
      setup do
        @product = Product.new(:tangible => true)
      end

      should "use that instance variable" do
        assert_bad_value Product, :price, "0", /included/
      end
    end
  end
  
end
