defmodule Webcamery.Repo.Migrations.AddUserIdToWebcam do
  use Ecto.Migration

  def change do
    alter table(:webcams) do
      add :user_id, references(:users), null: false
    end
  end
end
