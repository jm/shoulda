require File.join(File.dirname(__FILE__), '..', 'test_helper')

class MacrosTest < Test::Unit::TestCase # :nodoc:

  test "placeholder" do
    assert true
  end

  # context "an array of values" do
  #   setup do
  #     @a = [1, 2, "(3)"]
  #   end
  # 
  #   context "after adding another value" do
  #     setup do
  #       @a.push(4)
  #     end
  # 
  #     should_change "@a.length", :by => 1
  #     should_change "@a.length", :from => 3
  #     should_change "@a.length", :to => 4
  #     should_change "@a[0]", :by => 0
  #     should_not_change "@a[0]"
  #   end
  # 
  #   context "after replacing it with an array of strings" do
  #     setup do
  #       @a = %w(a b c d e f)
  #     end
  # 
  #     should_change "@a.length", :by => 3
  #     should_change "@a.length", :from => 3, :to => 6, :by => 3
  #     should_change "@a[0]"
  #     should_change "@a[1]", :from => 2, :to => "b"
  #     should_change "@a[2]", :from => /\d/, :to => /\w/
  #     should_change "@a[3]", :to => String
  #   end
  # end

end
