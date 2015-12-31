defmodule Webcamery.Repo.Migrations.CreateWebcam do
  use Ecto.Migration

  def change do
    create table(:webcams) do
      add :name, :string
      add :image_url, :string

      timestamps
    end

  end
end
