require 'shoulda'
require 'shoulda/adapters/active_record/assertions'
require 'shoulda/adapters/active_record/macros'

module Test # :nodoc: all
  module Unit
    class TestCase
      include Shoulda::Adapters::ActiveRecord::Assertions
      extend  Shoulda::Adapters::ActiveRecord::Macros
    end
  end
end
