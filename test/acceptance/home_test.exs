defmodule Webcamery.HomeAcceptanceTest do
  use Webcamery.AcceptanceCase

  alias Webcamery.Endpoint

  test "loading the home page" do
    navigate_to "/"
    assert page_source =~ "Webcamery"
  end

  test "shows multiple webcams" do
    user = insert_user
    insert_webcam(user)
    insert_webcam(user)

    navigate_to "/"

    assert (find_all_elements(:css, ".webcam") |> length) == 2
  end

  test "user navigates to webcam show page" do
    user = insert_user
    webcam = insert_webcam(user)

    navigate_to "/"
    click_on_webcam(webcam)

    assert current_path == webcam_path(Endpoint, :show, webcam)
  end

  def click_on_webcam(_webcam) do
    click({:class, "webcam"})
  end
end
