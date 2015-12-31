defmodule Webcamery.PageController do
  use Webcamery.Web, :controller
  alias Webcamery.Webcam

  def index(conn, _params) do
    webcams = Repo.all(Webcam)
    render conn, "index.html", webcams: webcams
  end
end
