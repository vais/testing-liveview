defmodule Ranger.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :body, :string

      timestamps(type: :utc_datetime)
    end
  end
end
