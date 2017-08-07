require 'pry'
class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      search_term = req.path.split("/items/").last
      search = @@items.find{|x| x.name == search_term}
        if search != nil
          resp.write search.price
        else
          resp.write "Item not found"
          resp.status = 400
        end
    else
        resp.write "Route not found"
        resp.status = 404
    end

    resp.finish
  end

end
