require 'routemaster/mixins'
require 'core_ext/string'

begin
  require "routemaster/services/exception_loggers/#{ENV.fetch('EXCEPTION_SERVICE', 'print')}"
rescue LoadError
  $stderr.puts "Please install and configure exception service first!"
  abort
end

module Routemaster::Mixins::LogException

  protected

  def deliver_exception(exception)
    # send the exception message to your choice of service!
    service = ENV.fetch('EXCEPTION_SERVICE', 'print').camelize
    Routemaster::Services::ExceptionLoggers.const_get(service).instance.process(exception)
  end

end
