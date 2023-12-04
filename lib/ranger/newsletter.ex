defmodule Ranger.Newsletter do
  alias Ranger.Newsletter.Subscription

  def new_subscription(attrs \\ %{}) do
    Subscription.changeset(%Subscription{}, attrs)
  end
end
