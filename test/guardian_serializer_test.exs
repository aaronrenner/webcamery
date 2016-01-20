defmodule Webcamery.GuardianSerializerTest do
  use Webcamery.ModelCase
  alias Webcamery.User

  test "for_token/1 returns a serialized representation of the user" do
    user = %User{id: 4}

    {:ok, serialized_user} = Webcamery.GuardianSerializer.for_token(user)
    assert serialized_user == "User:4"
  end

  test "for_token/1 when the user does not have an id" do
    user = %User{}

    {:error, reason} = Webcamery.GuardianSerializer.for_token(user)
    assert reason == "Unable to serialize resource"
  end

  test "from_token/1 returns the user for the given token" do
    user = insert_user
    token = "User:#{user.id}"

    {:ok, retrieved_user} = Webcamery.GuardianSerializer.from_token(token)

    assert_same_record(user, retrieved_user)
  end

  test "from_token/1 returns an error response if the user doesn't exist" do
    {:error, reason} = Webcamery.GuardianSerializer.from_token("User:5")

    assert reason == "Unable to find Webcamery.User with id=5"
  end

  test "from_token/1 returns an error response with an invalid token" do
    {:error, reason} = Webcamery.GuardianSerializer.from_token("Invalid")

    assert reason == "Unknown resource type"
  end

  def assert_same_record(a, b) do
    assert a.id == b.id
  end
end
