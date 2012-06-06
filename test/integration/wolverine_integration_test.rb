require File.join(File.expand_path('../../test_helper', __FILE__))

class WolverineIntegrationTest < MiniTest::Unit::TestCase

  CONTENT = File.read(File.expand_path('../lua/util/mexists.lua', __FILE__))

  def mock_redis
    Redis.new.tap { |r| r.set 'a', '1' }
  end

  def test_everything
    Wolverine.config.redis = mock_redis
    Wolverine.config.script_path = Pathname.new(File.expand_path('../lua', __FILE__))

    assert_equal [1, 0], Wolverine.util.mexists(:a, :b)
  end

end
