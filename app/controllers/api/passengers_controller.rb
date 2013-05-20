#encoding:utf-8
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
    @passenger = Passenger.where(:mobile => params[:mobile]).first
    if @passenger
      content = URI::encode("手机验证码:"+@passenger.password+" [天天打车]")
      render :json => {:code => Passenger.send_sms(params[:mobile],content) ,:passenger => @passenger}
    else
      randcode = rand(9999).to_s
      content = URI::encode("手机验证码:"+randcode+" [天天打车]")
      new_passenger = Passenger.new
      new_passenger.mobile = params[:mobile]
      new_passenger.password = randcode
      new_passenger.save
      render :json => {:code => Passenger.send_sms(params[:mobile],content),:passenger => new_passenger }
    end
  end

  def signin
    @passenger = Passenger.where(:mobile => params[:passenger][:mobile]).first
    if @passenger
       if @passenger.password == params[:passenger][:password]
     	  Passenger.update(@passenger.id,:lat => params[:passenger][:lat], :lng => params[:passenger][:lng], :online => 1)
          render :json => {:passenger =>@passenger}
       else
          render :json => {:error => '密码错误'}
       end
    else
      render :json => {:error => '用户不存在'}
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
