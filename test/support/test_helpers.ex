defmodule Webcamery.TestHelpers do
  alias Webcamery.Repo

  def insert_user(attrs \\ %{}) do
    changes = Dict.merge(%{
      email: "user#{Base.encode16(:crypto.rand_bytes(8))}@example.com",
      password: "supersecret"
    }, attrs)
    %Webcamery.User{}
    |> Webcamery.User.registration_changeset(changes)
    |> Repo.insert!()
  end

  def insert_webcam(user, attrs \\ %{}) do
    changes = Map.merge(%{
      name: "Camera 1",
      image_url: "http://www.example.com/image.jpg"
    }, attrs)

    webcam = Ecto.build_assoc(user, :webcams)
    Repo.insert! Webcamery.Webcam.changeset(webcam, changes)
  end
end
