defmodule Ranger.TimelineTest do
  use ExUnit.Case, async: true

  alias Ranger.Timeline

  describe "posts/1" do
    test "returns the requested number of posts" do
      posts = Timeline.posts(limit: 11)
      assert Enum.count(posts) == 11
    end

    test "returns the number of posts requested with offset" do
      set1 = MapSet.new(Timeline.posts(limit: 10, offset: 0))
      set2 = MapSet.new(Timeline.posts(limit: 10, offset: 10))
      assert MapSet.disjoint?(set1, set2)
    end
  end
end
