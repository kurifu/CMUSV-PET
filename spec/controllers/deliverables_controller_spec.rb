require 'spec_helper'

describe DeliverablesController do

  #Delete this example and add some real ones
  it "should use DeliverablesController" do
    controller.should be_an_instance_of(DeliverablesController)
  end

=begin
  it "should display the Phase page (index)" do
    session[:project_id] = 1
    get "index"
    response.should render_template("deliverables")
  end
=end

  it "it should populate via AJAX the deliverables table when I select a new phase" do
    
  end
end

