require 'juman/version'
require 'juman/process'
require 'juman/result'
require 'juman/morpheme'

class Juman
  JumanNotFoundError = Class.new(StandardError)
  
  def initialize(options = {})
    options[:juman_command] ||= "juman"
    @juman_command = `which #{options[:juman_command]}`.strip
    raise JumanNotFoundError unless $?.success?
    @process = Process.new("'#{@juman_command}' -B -e2")
  end

  def analyze(text)
    Result.new(@process.parse_to_enum(text))
  end
end
