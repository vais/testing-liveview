defmodule Ranger.GravatarTest do
  use ExUnit.Case

  test "generate_url/1" do
    email = "someone@example.com"
    url = Ranger.Gravatar.generate_url(email)
    assert String.starts_with?(url, "https://")
  end
end
