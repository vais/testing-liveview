defmodule RangerWeb.AboutComponents do
  import Phoenix.Component

  def card(assigns) do
    ~H"""
    <div class="border border-gray-300 rounded-xl p-5 flex flex-col gap-2">
      <div class="flex justify-between"><%= render_slot(@header) %></div>
      <div><%= render_slot(@inner_block) %></div>
    </div>
    """
  end

  def title(assigns) do
    ~H"""
    <span class="text-lg font-bold"><%= @text %></span>
    """
  end

  def badge(assigns) do
    ~H"""
    <span class={["px-2 py-1 rounded-md text-sm", colors_from_type(@type)]}><%= @type %></span>
    """
  end

  defp colors_from_type("hobbit"), do: "bg-green-700 text-green-100"
  defp colors_from_type("human"), do: "bg-blue-700 text-blue-100"
  defp colors_from_type("dwarf"), do: "bg-yellow-700 text-yellow-100"
  defp colors_from_type("wizard"), do: "bg-red-700 text-red-100"
  defp colors_from_type("elf"), do: "bg-gray-700 text-gray-100"
end
