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
end
