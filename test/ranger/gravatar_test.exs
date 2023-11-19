defmodule Ranger.GravatarTest do
  use ExUnit.Case

  test "generate_url/1" do
    email = "  MyEmailAddress@example.com "
    hash = "84059b07d4be67b806386c0aad8070a23f18836bbaae342275dc0a83414c32ee"
    expected = "https://gravatar.com/avatar/#{hash}"
    actual = Ranger.Gravatar.generate_url(email)
    assert actual == expected
  end
end
