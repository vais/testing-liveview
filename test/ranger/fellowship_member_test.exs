defmodule Ranger.FellowshipMemberTest do
  use ExUnit.Case
  alias Ranger.FellowshipMember

  test "new/3" do
    assert %FellowshipMember{name: "Frodo", type: "hobbit", description: "the main dude"} =
             FellowshipMember.new("Frodo", "hobbit", "the main dude")
  end

  test "characters/0" do
    assert [%FellowshipMember{} | _rest] = FellowshipMember.characters()
  end
end
