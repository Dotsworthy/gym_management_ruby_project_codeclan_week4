require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../action')


class ActionTest < MiniTest::Test

  def test_time_check_true_equal_to_time()
    result = Time.now
    assert_equal(true, time_check(result))
  end

  def test_time_check_true_after_time()
    result = Time.now + 30
    assert_equal(true, time_check(result))
  end

  def test_time_false()
    result = Time.now - 30
    assert_equal(false, time_check(result))
  end
end
