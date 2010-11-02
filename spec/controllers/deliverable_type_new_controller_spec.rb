require 'spec_helper'

describe DeliverableTypeNewController do

  integrate_views
  
  #Delete this example and add some real ones
  it "should use DeliverableTypeNewController" do
    controller.should be_an_instance_of(DeliverableTypeNewController)
  end

  it "should get the new page" do
    get 'new'
    response.should render_template("deliverable_type_new/new")
    response.should have_tag('div.content#new_del')
    response.should have_tag('table#pet_table')
    response.should have_tag('div#pet_calc_div')
    #response.should have_tag('a[href=?]', "#", :text => "Calculate")
    #response.should have_tag('a[href=?]', "#", :text => "Reset")

    # Historical Data link
    response.should have_tag('a[href=?]', "#", :text => "Historical Data")

    response.should have_tag "form[action=/deliverable_type_new]" do
      with_tag "input[type=text][name='deliverable[deliverable_type]']"
      with_tag "input[type=text][name='deliverable[name]']"
      with_tag "textarea[name='deliverable[description]']"
      with_tag "input[type=text][name='deliverable[complexity]']"
      with_tag "input[type=text][name='deliverable[unit_measurement]']"
      with_tag "input[type=text][name='deliverable[estimated_size]']"
      with_tag "input[type=text][name='deliverable[production_rate]']"
      with_tag "input[type=text][name='deliverable[estimated_effort]']"
      with_tag "input[type=submit][name='commit'][id=deliverable_submit]"
    end
  end

  it "should submit an AJAX request when I click 'Calculate" do
    
  end
end
