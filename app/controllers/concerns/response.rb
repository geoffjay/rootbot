# Mixin to simplify the JSON response render
module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
