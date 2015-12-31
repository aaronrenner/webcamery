defmodule Webcamery.WebcamTest do
  use Webcamery.ModelCase

  alias Webcamery.Webcam

  @valid_attrs %{image_url: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Webcam.changeset(%Webcam{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Webcam.changeset(%Webcam{}, @invalid_attrs)
    refute changeset.valid?
  end
end
