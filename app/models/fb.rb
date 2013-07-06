class Fb
  require "fbgraph"
  @@static_client = nil

  attr_accessor :client

  def initialize(token)
    @client ||= FBGraph::Client.new(
      client_id: ENV['FACEBOOK_KEY'],
      secret_id: ENV['FACEBOOK_SECRET'],
      token:     token
    )
    @client
  end

  def self.set_current_user token
    @@static_client = Fb.new(token)
  end

  def self.current_user_client
    @@static_client
  end

end
