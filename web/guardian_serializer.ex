defmodule Webcamery.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias Webcamery.User
  alias Webcamery.Repo

  def for_token(%User{id: user_id}) when is_integer(user_id) do
    {:ok, "User:#{user_id}"}
  end
  def for_token(_) do
    {:error, "Unable to serialize resource"}
  end

  def from_token("User:" <> user_id) do
    user = Repo.get(User, user_id)
    if user do
      {:ok, user}
    else
      {:error, "Unable to find Webcamery.User with id=#{user_id}"}
    end
  end
  def from_token(_) do
    {:error, "Unknown resource type"}
  end
end
