defmodule Webcamery.Router do
  use Webcamery.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Webcamery.Auth, repo: Webcamery.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Webcamery do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/webcam", WebcamController, only: [:show]

    get "/sign_in", SessionController, :new
    resources "/sessions", SessionController,
      singleton: true, only: [:create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Webcamery do
  #   pipe_through :api
  # end
end
