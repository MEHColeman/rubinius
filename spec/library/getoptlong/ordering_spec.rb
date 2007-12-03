require File.dirname(__FILE__) + '/../../spec_helper'
require 'getoptlong'

describe "GetoptLong#ordering=" do
  it "should raise an ArgumentError if called after processing has started" do
    begin
      s = $stderr
      $stderr = dev_null
      old_argv = ARGV
      ARGV = [ "--size", "10k", "--verbose" ]
      
      opts = GetoptLong.new([ '--size', GetoptLong::REQUIRED_ARGUMENT ],
        [ '--verbose', GetoptLong::NO_ARGUMENT ])
      opts.get
      
      lambda {
        opts.ordering = GetoptLong::PERMUTE
      }.should raise_error(ArgumentError
    ensure
      ARGV = old_argv
      $stderr = s
    end
  end

  it "should raise an ArgumentError if given an invalid value" do
    opts = GetoptLong.new
    
    lambda {
      opts.ordering = 12345
    }.should raise_error(ArgumentError)
  end
  
  it "should not allow changing ordering to PERMUTE if ENV['POSIXLY_CORRECT'] is set" do
    begin
      old_env_value = ENV['POSIXLY_CORRECT']
      ENV['POSIXLY_CORRECT'] = ""
      
      opts = GetoptLong.new
      opts.ordering = GetoptLong::PERMUTE
      opts.ordering.should == GetoptLong::REQUIRE_ORDER
    ensure
      ENV['POSIXLY_CORRECT'] = old_env_value
    end
  end
end