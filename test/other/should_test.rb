require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ShouldTest < Test::Unit::TestCase # :nodoc:
  
  should "be able to define a should statement outside of a context" do
    assert true
  end
  
  should "see the name of my class as ShouldTest" do
    assert_equal "ShouldTest", self.class.name
  end
  
  def self.should_see_class_methods
    should "be able to see class methods" do
      assert true
    end
  end

  def self.should_see_a_context_block_like_a_Test_Unit_class
    should "see a context block as a Test::Unit class" do
      assert_equal "ShouldTest", self.class.name
    end
  end

  def self.should_see_blah
    should "see @blah through a macro" do
      assert @blah 
    end
  end

  def self.should_not_see_blah
    should "not see @blah through a macro" do
      assert_nil @blah 
    end
  end

  def self.should_be_able_to_make_context_macros(prefix = nil)
    context "a macro" do
      should "have the tests named correctly" do
        assert_match(/^test: #{prefix}a macro should have the tests named correctly/, self.to_s)
      end
    end
  end

  context "Context" do
    should_see_class_methods
    should_see_a_context_block_like_a_Test_Unit_class
    should_be_able_to_make_context_macros("Context ")

    should "not define @blah" do
      assert ! self.instance_variables.include?("@blah")
    end

    should_not_see_blah

    should "be able to define a should statement" do
      assert true
    end

    should "see the name of my class as ShouldTest" do
      assert_equal "ShouldTest", self.class.name
    end

    context "with a subcontext" do
      should_be_able_to_make_context_macros("Context with a subcontext ")
    end
  end

  context "Context with setup block" do
    setup do
      @blah = "blah"
    end
    
    should "have @blah == 'blah'" do
      assert_equal "blah", @blah
    end
    
    should_see_blah
    
    should "have name set right" do
      assert_match(/^test: Context with setup block/, self.to_s)
    end

    context "and a subcontext" do
      setup do
        @blah = "#{@blah} twice"
      end
      
      should "be named correctly" do
        assert_match(/^test: Context with setup block and a subcontext should be named correctly/, self.to_s)
      end
      
      should "run the setup methods in order" do
        assert_equal @blah, "blah twice"
      end
      
      should_see_blah
    end
  end

  context "Another context with setup block" do
    setup do
      @blah = "foo"
    end
    
    should "have @blah == 'foo'" do
      assert_equal "foo", @blah
    end

    should "have name set right" do
      assert_match(/^test: Another context with setup block/, self.to_s)
    end
    should_see_blah
  end

  # Context creation and naming

  def test_should_create_a_new_context
    assert_nothing_raised do
       Class.new(Test::Unit::TestCase).context("context name") do; end
    end
  end

  def test_should_create_a_nested_context
    assert_nothing_raised do
      parent = Thoughtbot::Shoulda::Context.new("Parent", self) do; end
      child  = Thoughtbot::Shoulda::Context.new("Child", parent) do; end
    end
  end

  def test_should_name_a_contexts_correctly
    parent     =  Class.new(Test::Unit::TestCase).context("Parent", self) do; end
    child      =  Class.new(Test::Unit::TestCase).context("Child", parent) do; end
    grandchild =  Class.new(Test::Unit::TestCase).context("GrandChild", child) do; end

    assert_equal "Parent", parent.full_name
    assert_equal "Parent Child", child.full_name
    assert_equal "Parent Child GrandChild", grandchild.full_name
  end

  # Should statements

  def test_should_have_should_hashes_when_given_should_statements
    context = Class.new(Test::Unit::TestCase).context("name") do
      should "be good" do; end
      should "another" do; end
    end
    
    names = context.shoulds.map {|s| s[:name]}
    assert_equal ["another", "be good"], names.sort
  end

  # setup and teardown

  def test_should_capture_setup_and_teardown_blocks
    context =  Class.new(Test::Unit::TestCase).context("name") do
      setup    do; "setup";    end
      teardown do; "teardown"; end
    end
    
    assert_equal "setup",    context.setup_blocks.first.call
    assert_equal "teardown", context.teardown_blocks.first.call
  end

end
