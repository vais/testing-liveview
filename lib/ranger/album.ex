defmodule Ranger.Album do
  use Ecto.Schema
  import Ecto.Changeset

  schema "albums" do
    field :name, :string
    field :urls, {:array, :string}, default: []

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(album \\ %__MODULE__{}, attrs) do
    album
    |> cast(attrs, [:name, :urls])
    |> validate_required([:name, :urls])
  end
end
