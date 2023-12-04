defmodule Ranger.Newsletter.Subscription do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ranger.Newsletter.Subscription

  embedded_schema do
    field :email, :string
  end

  @doc false
  def changeset(%Subscription{} = subscription, attrs) do
    subscription
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> validate_format(:email, ~r/@/)
  end
end
