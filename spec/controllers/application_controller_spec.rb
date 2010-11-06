require 'spec_helper'

describe ApplicationController do

  #Delete this example and add some real ones
  it "should use ApplicationController" do
    controller.should be_an_instance_of(ApplicationController)
  end

  it "should direct to error page" do
    get  :somethingwrong
    response.should redirect_to "/error"
  end

end
