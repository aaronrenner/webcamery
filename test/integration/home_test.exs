defmodule Webcamery.IntegrationTests.HomeTest do
  use Webcamery.IntegrationCase

  alias Webcamery.Repo
  alias Webcamery.Webcam
  alias Webcamery.Endpoint

  test "loading the home page" do
    navigate_to "/"
    assert page_source =~ "Webcamery"
  end

  test "shows multiple webcams" do
    Repo.insert! %Webcam{name: "Camera 1", image_url: "http://www.example.com/image.jpg"}
    Repo.insert! %Webcam{name: "Camera 2", image_url: "http://www.example.com/image_2.jpg"}

    navigate_to "/"

    assert (find_all_elements(:css, ".webcam") |> length) == 2
  end

  test "user navigates to webcam show page" do
    webcam = Repo.insert! %Webcam{name: "Camera 1", image_url: "http://www.example.com/image.jpg"}

    navigate_to "/"
    click_on_webcam(webcam)

    assert current_path == webcam_path(Endpoint, :show, webcam)
  end

  def click_on_webcam(_webcam) do
    click({:class, "webcam"})
  end
end
