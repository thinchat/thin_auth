class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  # attr_accessible :title, :body

  ACCEPTED_DOMAINS = [ 'hungrymachine.com', 'livingsocial.com' ]

  def self.find_for_open_id(access_token, signed_in_resource=nil)
    data = access_token.info
    return User.new if not approved_email? data["email"]

    if user = User.where(:email => data["email"]).first
      user
    else
      User.create!(:email => data["email"], :name => data["name"], :password => Devise.friendly_token[0,20])
    end
  end

  def self.approved_email?(email)
    domain = email.split('@').last
    ACCEPTED_DOMAINS.include? domain
  end

  def to_json
    super(:except => :password)
  end
end
