defmodule Webcamery.UserTest do
  use Webcamery.ModelCase, async: true
  alias Webcamery.User

  @valid_attrs %{email: "a@a.com", password: "secret"}
  @invalid_attrs %{}

  test "changeset/2 with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset/2 with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset/2 password must be at least 6 chars long when set" do
    attrs = %{@valid_attrs | password: "no"}
    changeset = User.changeset(%User{}, attrs)

    refute changeset.valid?
    assert {:password, {"should be at least %{count} character(s)", count: 6}}
      in changeset.errors
  end

  test "changeset/2 is still valid when password is not set" do
    attrs = Map.delete(@valid_attrs, :password)
    changeset = User.changeset(%User{}, attrs)

    assert changeset.valid?
  end

  test "changeset/2 with valid attributes hashes password" do
    attrs = %{@valid_attrs | password: "superstrong"}
    changeset = User.changeset(%User{}, attrs)
    %{password: pass, password_hash: pass_hash} = changeset.changes

    assert changeset.valid?
    assert pass_hash
    assert Comeonin.Bcrypt.checkpw(pass, pass_hash)
  end

  test "registration_changeset/2 with valid attributes hashes password" do
    attrs = %{@valid_attrs | password: "superstrong"}
    changeset = User.registration_changeset(%User{}, attrs)
    %{password: pass, password_hash: pass_hash} = changeset.changes

    assert changeset.valid?
    assert pass_hash
    assert Comeonin.Bcrypt.checkpw(pass, pass_hash)
  end

  test "registration_changeset/2 not valid if password is missing" do
    attrs = Map.delete(@valid_attrs, :password)
    changeset = User.registration_changeset(%User{}, attrs)

    refute changeset.valid?

    assert {:password, "can't be blank"} in changeset.errors
  end
end
