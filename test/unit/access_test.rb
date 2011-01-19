require 'test_helper'

class AccessTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Access.new.valid?
  end
end
