defmodule Webcamery.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias Webcamery.Router.Helpers
  import Comeonin.Bcrypt, only: [checkpw: 2]

  def login(conn, user) do
    Guardian.Plug.sign_in(conn, user)
  end

  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def login_by_username_and_pass(conn, email, given_pass, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(Webcamery.User, email: email)

    cond do
      user && checkpw(given_pass, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        {:error, :not_found, conn}
    end
  end

  def logout(conn) do
    Guardian.Plug.sign_out(conn)
  end
end
