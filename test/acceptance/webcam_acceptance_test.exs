defmodule Webcamery.WebcamAcceptanceTest do
  use Webcamery.AcceptanceCase

  test "a logged in user manages their webcams" do
    user = insert_user
    sign_in_as user

    navigate_to "/"

    click({:link_text,  "My Webcams"})
    click({:link_text,  "New"})

    fill_out_webcam_form(%{name: "Aaron's Office"})

    assert page_source =~ "Aaron's Office"

    click({:link_text, "Edit"})

    fill_out_webcam_form(%{name: "Aaron's Porch"})
    assert page_source =~ "Aaron's Porch"

    click({:link_text, "Delete"})

    assert page_source =~ "successfully deleted"
    refute page_source =~ "Aaron's Porch"
  end

  def fill_out_webcam_form(attrs \\ %{}) do
    attrs = Map.merge(%{
      name: "Sample Webcam",
      image_url: "http://placehold.it/200"
    }, attrs)
    fill_field({:name, "webcam[name]"},  attrs[:name])
    fill_field({:name, "webcam[image_url]"}, attrs[:image_url])
    click({:css, "[type=submit]"})
  end

  def sign_in_as(user) do
    navigate_to "/"
    click({:link_text, "Sign In"})
    sign_in_with(user.email, user.password)
  end

  defp sign_in_with(email, password) do
    fill_field({:name, "session[email]"},  email)
    fill_field({:name, "session[password]"}, password)
    click({:css, "[type=submit]"})
  end
end
