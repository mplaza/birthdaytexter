class FriendsController < ApplicationController
  def index
    @friends = Friend.all
    @graph = Koala::Facebook::API.new(current_user.access_token)
    @userbirthday = @graph.get_object("me?fields=birthday")["birthday"]
    @userfriends = @graph.get_connections("me", "friends")
    # fb_userdata(current_user.access_token, current_user.uid) 
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

  # def fb_userdata(access_token, uid)
  #   @id = uid
  #   @access_token = access_token
  #   @response_hash = MiniFB.get(@access_token, @id)
  #   puts "THIS IS THE #{@response_hash}"
  # end


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

    def text_confirm(friend)
      get '/sms-quickstart' do
      reply = params[:Body]
      if reply == 'yes'
          @twiml = Twilio::TwiML::Response.new do |r|
          r.Message "Great. We'll send the message."
      end
          @twiml.text
      end
      end

    end
 


  def friend_params
  	params.require(:friend).permit(:name, :number, :email, :message, :monthbirth, :daybirth, :user_id)
  end

end
