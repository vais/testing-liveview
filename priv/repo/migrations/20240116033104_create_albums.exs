defmodule Ranger.Repo.Migrations.CreateAlbums do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :name, :string, null: false
      add :urls, {:array, :string}, null: false, default: []

      timestamps(type: :utc_datetime)
    end
  end
end
