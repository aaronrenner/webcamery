defmodule Webcamery.WebcamController do
  use Webcamery.Web, :controller
  alias Webcamery.Webcam

  def show(conn, %{"id" => id}) do
    webcam = Repo.get!(Webcam, id)

    render conn, "show.html", webcam: webcam
  end
end
