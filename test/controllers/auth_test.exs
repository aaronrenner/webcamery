defmodule Webcamery.AuthTest do
  use Webcamery.ConnCase
  alias Webcamery.Auth

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(Webcamery.Router, [:browser, :browser_session])
      |> get("/")
    {:ok, conn: conn}
  end

  test "login stores the current user", %{conn: conn} do
    user = insert_user
    login_conn =
      conn
      |> Auth.login(user)
      |> send_resp(:ok, "")

    next_conn = get(login_conn, "/")
    assert Auth.current_user(next_conn).id == user.id
  end

  test "logout drops the session", %{conn: conn} do
    login_conn =
      conn
      |> put_session(:user_id, 123)
      |> Auth.logout()
      |> send_resp(:ok, "")

    next_conn = get(login_conn, "/")
    refute get_session(next_conn, :user_id) == 123
  end

  test "login with a valid email and pass", %{conn: conn} do
    user = insert_user(email: "me@example.com", password: "secret")

    {:ok, conn} =
      Auth.login_by_username_and_pass(conn, "me@example.com", "secret", repo: Repo)

    assert Auth.current_user(conn).id == user.id
  end

  test "login with a not found user", %{conn: conn } do
    assert {:error, :not_found, _conn} =
      Auth.login_by_username_and_pass(conn, "me@example.com", "secret", repo: Repo)
  end

  test "login with password mismatch", %{conn: conn } do
    insert_user(email: "me@example.com", password: "secret")

    assert {:error, :unauthorized, _conn} =
      Auth.login_by_username_and_pass(conn, "me@example.com", "wrong", repo: Repo)
  end
end
