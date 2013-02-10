$:.unshift File.expand_path(File.dirname(__FILE__))
require 'juman/process'
require 'juman/result'
require 'juman/morpheme'

class Juman
  def initialize
    @process = Process.new('juman -e2 -B')
  end

  def analyze text
    @process.puts(text)
    Result.new(@process.readlines)
  end
end