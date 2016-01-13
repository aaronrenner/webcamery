defmodule Integration.AuthenticationTest do
  use Webcamery.IntegrationCase

  test "successful log in with email and password" do
    insert_user email: "user@example.com", password: "secret"

    navigate_to "/"

    click({:link_text, "Sign In"})

    sign_in_with("user@example.com", "secret")

    assert logged_in?
  end

  test "login with invalid email" do
    insert_user email: "user@example.com", password: "secret"

    navigate_to "/"

    click({:link_text, "Sign In"})

    sign_in_with("invalid@example.com", "secret")

    assert login_form_visible?
  end

  test "login with invalid password" do
    insert_user email: "user@example.com", password: "secret"

    navigate_to "/"

    click({:link_text, "Sign In"})

    sign_in_with("user@example.com", "invalid")

    assert login_form_visible?
  end

  test "log in and log out" do
    insert_user email: "user@example.com", password: "secret"

    navigate_to "/"

    click({:link_text, "Sign In"})

    sign_in_with("user@example.com", "secret")

    assert logged_in?

    click({:link_text, "Sign Out"})

    refute logged_in?
  end

  defp login_form_visible? do
     find_element(:name, "session[email]")
  end

  defp logged_in? do
    page_source =~ "Sign Out"
  end

  defp sign_in_with(email, password) do
    fill_field({:name, "session[email]"},  email)
    fill_field({:name, "session[password]"}, password)
    click({:css, "[type=submit]"})
  end
end
