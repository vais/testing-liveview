defmodule Ranger.NewsletterTest do
  use ExUnit.Case

  alias Ranger.Newsletter
  alias Ranger.Newsletter.Subscription

  describe "new_subscription/0" do
    test "returns subscription changeset" do
      assert %Ecto.Changeset{data: %Subscription{}, changes: %{}} = Newsletter.new_subscription()
    end
  end

  describe "new_subscription/1" do
    test "returns subscription changeset with the requested changes" do
      assert %Ecto.Changeset{data: %Subscription{}, changes: %{email: "someone@example.com"}} =
               Newsletter.new_subscription(%{"email" => "someone@example.com"})
    end
  end
end
