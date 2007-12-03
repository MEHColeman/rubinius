require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/fixtures/classes'

describe "Bignum#<=" do
  before(:each) do
    @bignum = BignumHelper.sbm(39)
  end

  it "returns true if self is less than or equal to other" do
    (@bignum <= @bignum).should == true
    (-@bignum <= -(@bignum - 1)).should == true
    
    (@bignum <= (@bignum + 0.5)).should == true
    (@bignum <= 4.999).should == false
  end

  it "raises an ArgumentError when given a non-Integer" do
    lambda { @bignum <= "4" }.should raise_error(ArgumentError)
    lambda { @bignum <= Object.new }.should raise_error(ArgumentError)
  end
end
