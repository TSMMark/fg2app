class RequestError
  
  def initialize(code=404)
    @code = code
    case @code
    when 403
      @type     = 'Access Denied'
      @message  = 'You do not have permission to access this resource.'
    else
      @code     = 404
      @type     = 'Not Found'
      @message  = 'The resource you requested was not found.'
    end

  end

  #def as_json(options={})
  #  super #.merge()
  #end

end