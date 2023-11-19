defmodule Ranger.Gravatar do
  @base_url "https://gravatar.com/avatar/"

  def generate_url(email) do
    @base_url <> email_hash(email)
  end

  defp email_hash(email) do
    email
    |> String.trim()
    |> String.downcase()
    |> hash()
  end

  defp hash(str) do
    :sha256
    |> :crypto.hash(str)
    |> Base.encode16(case: :lower)
  end
end
