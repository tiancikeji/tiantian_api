class Api::DriversController < ApplicationController
  def index
    @drivers = Driver.geo_scope(:within => 5 ,:units => :km, :origin => GeoKit::LatLng.new(params[:driver][:lat],params[:driver][:lng]))
    # update passenger lat and lng
    @passenger = Passenger.where(' iosDevice = ? or androidDevice = ?',params[:driver][:iosDevice],params[:driver][:androidDevice]).first
    if @passenger
      Passenger.update(@passenger.id,:lat => params[:driver][:lat], :lng => params[:driver][:lng], :online => 1)
    end
    render :json => {:drivers => @drivers}
  end

  def show
    @driver = Driver.find(params[:id])
    render :json => {:driver => @driver}
  end

  def signup
    @driver = Driver.new(params[:driver])
    if @driver.save
      render json: @driver, status: :created, location: @driver 
    else
       render json: @driver.errors, status: :unprocessable_entity 
    end
  end

  def signin
    @driver = Driver.where(:mobile => params[:driver][:mobile]).first
    if @driver
       if @driver.password == params[:driver][:password]
     	  Driver.update(@driver.id,:lat => params[:driver][:lat], :lng => params[:driver][:lng], :online => 1)
          render :json => {:driver => @driver}
       else
          render :json => {:error => 'password is not correct'}
       end
    else
      render :json => {:error => 'this driver is not exist'}
    end

  end

  def signout
    @driver = Driver.where('androidDevice = ?', params[:driver][:androidDevice]).first
    if @driver
      Driver.update(@driver.id,:online => 0)
    end
    render :json => {:message =>'logout success'}
  end

  def update
    @driver = Driver.find(params[:id])
      if @driver.update_attributes(params[:driver])
        render :json => { :driver => @driver }
      else
        render json: @driver.errors, status: :unprocessable_entity
      end
  end

  def destroy
    @driver = Driver.find(params[:id])
    @driver.destroy
    render :json => {:info => 'this driver is not exist'}
  end
end
