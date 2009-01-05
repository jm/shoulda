require 'shoulda'
require 'shoulda/adapters/action_controller/helpers'
require 'shoulda/adapters/action_controller/macros'
require 'shoulda/adapters/active_record/assertions'
require 'shoulda/adapters/action_mailer'

module Test # :nodoc: all
  module Unit
    class TestCase
      extend  Shoulda::Adapters::ActionController::Macros
      include Shoulda::Adapters::ActionController::Helpers
    end
  end
end

module ActionController #:nodoc: all
  module Integration
    class Session
      include Shoulda::Adapters::ActiveRecord::Assertions
    end
  end
end
