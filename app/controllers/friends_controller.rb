class FriendsController < ApplicationController
  def index
    @friends = Friend.all
    fb_userdata(current_user.uid)
  end

  def new
  	@friend = Friend.new
  end

  def create
  	@friend = Friend.new(friend_params)
  	if @friend.save
  	  scheduler = Rufus::Scheduler.new
  	  scheduler.at @friend.convertdate do 
        text_updates(@friend)
        scheduler.every '1m' do
  	  	 puts "#{@friend.name}"
        end
  	  end
      redirect_to friends_path
    else
      render 'new'
    end
  end

  def show
  	@friend = Friend.find(params[:id])
  end

  def fb_userdata(uid)
    @uid = uid
    user_hash = MiniFB.call(ENV['APP_ID'], ENV['APP_SECRET'], "Users.getInfo", "session_key"=>@session_key, "uids"=>@uid, "fields"=>"birthday")
    puts "THIS IS THE #{user_hash}"
  end


    def text_updates(friend)
    @friend = friend
    # @account_sid = ENV["TWILIO_ID"]
    # @auth_token = ENV["TWILIO_SECRET"]
        # set up a client to talk to the Twilio REST API 
        @client = Twilio::REST::Client.new ENV["TWILIO_ID"], ENV["TWILIO_SECRET"]  
        @client.account.messages.create({
          :from => ENV["TWILIO_PHONE"], 
          :to => "#{@friend.number}",
          :body => "#{@friend.name}: #{@friend.message}"
          })
    end
 


  def friend_params
  	params.require(:friend).permit(:name, :number, :email, :message, :monthbirth, :daybirth, :user_id)
  end

end
