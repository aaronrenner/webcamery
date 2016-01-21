defmodule Webcamery.User do
  use Webcamery.Web, :model

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :webcams, Webcamery.Webcam

    timestamps
  end

  @required_fields ~w(email)
  @optional_fields ~w(password)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  def registration_changeset(model, params ) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: pass}} = changeset) do
    put_change(changeset, :password_hash,
      Comeonin.Bcrypt.hashpwsalt(pass)
    )
  end
  defp put_pass_hash(changeset) do
    changeset
  end

end
