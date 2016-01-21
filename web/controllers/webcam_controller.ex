defmodule Webcamery.WebcamController do
  use Webcamery.Web, :controller
  alias Webcamery.Webcam
  alias Webcamery.Auth

  def index(conn, _) do
    render conn, "index.html"
  end

  def show(conn, %{"id" => id}) do
    webcam = Repo.get!(Webcam, id)

    render conn, "show.html", webcam: webcam
  end

  def new(conn, _) do
    changeset = Auth.current_user(conn)
    |> build_assoc(:webcams)
    |> Webcam.changeset()

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"webcam" => webcam_params}) do
    changeset = Auth.current_user(conn)
    |> build_assoc(:webcams)
    |> Webcam.changeset(webcam_params)

    case Repo.insert(changeset) do
      {:ok, webcam} ->
        conn
        |> put_flash(:info, "Webcam created successfully")
        |> redirect(to: webcam_path(conn, :show, webcam))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => id}) do
    webcam = Repo.get!(current_user_webcams(conn), id)
    changeset = Webcam.changeset(webcam)
    render conn, "edit.html", changeset: changeset, webcam: webcam
  end

  def update(conn, %{"id" => id, "webcam" => webcam_params}) do
    webcam = Repo.get!(current_user_webcams(conn), id)
    changeset = Webcam.changeset(webcam, webcam_params)

    case Repo.update(changeset) do
      {:ok, webcam} ->
        conn
        |> put_flash(:info, "Webcam updated successfully")
        |> redirect(to: webcam_path(conn, :show, webcam))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, webcam: webcam
    end
  end

  def delete(conn, %{"id" => id}) do
    webcam = Repo.get!(current_user_webcams(conn), id)

    Repo.delete!(webcam)

    conn
    |> put_flash(:info, "Webcam successfully deleted")
    |> redirect(to: webcam_path(conn, :index))
  end

  def current_user_webcams(conn) do
    Auth.current_user(conn)
    |>assoc(:webcams)
  end
end
