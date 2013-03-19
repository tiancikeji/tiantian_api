class Api::PassengersController < ApplicationController
  def index
    @passengers = Passenger.geo_scope(:within => 5 ,:units => :km, :origin => GeoKit::LatLng.new(params[:passenger][:lat],params[:passenger][:lng]))
    @driver = Driver.where('iosDevice = ? or androidDevice = ?', params[:passenger][:iosDevice],params[:passenger][:androidDevice]).first
    if @driver
      Driver.update(@driver.id,:lat => params[:passenger][:lat] , :lng => params[:passenger][:lng], :online => 1)
    end
    render :json => {:passengers =>@passengers}
  end

  def show
    @passenger = Passenger.find(params[:id])
    render :json => {:passenger =>@passenger}
  end

  def get_verification_code
    content = URI::encode(" tiantiandache "+rand(9999).to_s)
    render :json => {:code => Passenger.get_verification_code(params[:mobile],content) }
  end

  def signup 
    @passenger = Passenger.new(params[:passenger])
    if @passenger.save
       render :json => {:passenger =>@passenger}
    else
       render json: @passenger.errors, status: :unprocessable_entity 
    end
  end

  def signin
    @passenger = Passenger.where(:mobile => params[:passenger][:mobile]).first
    if @passenger
       if @passenger.password == params[:passenger][:password]
          render :json => {:passenger =>@passenger}
       else
          render :json => {:error => 'password is not correct'}
       end
    else
      render :json => {:error => 'this driver is not exist'}
    end
  end

  def signout
    @passenger = Passenger.where(' iosDevice = ? or androidDevice = ?',params[:passenger][:iosDevice],params[:passenger][:androidDevice]).first
    if @passenger
      Passenger.update(@passenger.id, :online => 0)
    end
    render :json => {:message => 'logout success'}
  end

  def update
    @passenger = Passenger.find(params[:id])

      if @passenger.update_attributes(params[:passenger])
         head :no_content 
      else
         render json: @passenger.errors, status: :unprocessable_entity 
      end
  end

  def destroy
    @passenger = Passenger.find(params[:id])
    @passenger.destroy
    head :no_content
  end

end
