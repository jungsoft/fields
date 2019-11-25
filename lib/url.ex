defmodule Fields.Url do
  @moduledoc """
  An Ecto Type for urls.
  Use `Fields.UrlEncrypted` for encrypted urls.

  ## Example

      schema "retailers" do
        field(:url, Fields.Url)
      end
  """
  alias Fields.Validate

  @behaviour Ecto.Type

  def type, do: :string

  def cast(value) do
    value = value |> to_string() |> String.trim()
    {:ok, value}
  end

  def dump(value) do
    {:ok, to_string(value)}
  end

  def load(value) do
    {:ok, value}
  end

  def embed_as(_value), do: :dump

  def equal?(a, b), do: a == b
end
