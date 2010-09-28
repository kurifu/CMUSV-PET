class TempsController < ApplicationController
  # GET /temps
  # GET /temps.xml
  def index
    @temps = Temp.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @temps }
    end
  end

  # GET /temps/1
  # GET /temps/1.xml
  def show
    @temp = Temp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @temp }
    end
  end

  # GET /temps/new
  # GET /temps/new.xml
  def new
    @temp = Temp.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @temp }
    end
  end

  # GET /temps/1/edit
  def edit
    @temp = Temp.find(params[:id])
  end

  # POST /temps
  # POST /temps.xml
  def create
    @temp = Temp.new(params[:temp])

    respond_to do |format|
      if @temp.save
        format.html { redirect_to(@temp, :notice => 'Temp was successfully created.') }
        format.xml  { render :xml => @temp, :status => :created, :location => @temp }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @temp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /temps/1
  # PUT /temps/1.xml
  def update
    @temp = Temp.find(params[:id])

    respond_to do |format|
      if @temp.update_attributes(params[:temp])
        format.html { redirect_to(@temp, :notice => 'Temp was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @temp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /temps/1
  # DELETE /temps/1.xml
  def destroy
    @temp = Temp.find(params[:id])
    @temp.destroy

    respond_to do |format|
      format.html { redirect_to(temps_url) }
      format.xml  { head :ok }
    end
  end
end
