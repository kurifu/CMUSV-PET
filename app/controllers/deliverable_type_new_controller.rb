class DeliverableTypeNewController < ApplicationController

  def new
    puts "INSIDE NEW"
    @deliverable = Deliverable.new
    respond_to do |format|
      format.html
    end
  end

end
