require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class EspSdkTest < ActiveSupport::TestCase
  context 'EspSdk' do
    context '#env' do
      setup do
        EspSdk.instance_variable_set(:@env, nil)
        ENV['ESP_ENV'] = nil
      end

      should 'return :production when ENV is not set' do
        ENV.expects(:[]).returns(nil).at_least_once
        assert_equal :production, EspSdk.env
      end

      should 'return :release when ENV[ESP_ENV] is set to release' do
        ENV.expects(:[]).returns('release').at_least_once
        assert_equal :release, EspSdk.env
      end
    end

    context '#production?' do
      should 'return true when the environment is :production' do
        EspSdk.expects(:env).returns(:production)
        assert EspSdk.production?
      end

      should 'return false when the environment is not :production' do
        EspSdk.expects(:env).returns(:release)
        refute EspSdk.production?
      end
    end

    context '#release?' do
      should 'return true when the environment is :release' do
        EspSdk.expects(:env).returns(:release)
        assert EspSdk.release?
      end

      should 'return false when the environment is not :release' do
        EspSdk.expects(:env).returns(:test)
        refute EspSdk.release?
      end
    end

    context '#development?' do
      should 'return true when the environment is :development' do
        EspSdk.expects(:env).returns(:development)
        assert EspSdk.development?
      end

      should 'return false when the environment is not :development' do
        EspSdk.expects(:env).returns(:test)
        refute EspSdk.development?
      end
    end

    context '#test?' do
      should 'return true when the environment is :test' do
        EspSdk.expects(:env).returns(:test)
        assert EspSdk.test?
      end

      should 'return false when the environment is not :test' do
        EspSdk.expects(:env).returns(:production)
        refute EspSdk.test?
      end
    end
  end
end