defmodule Fields.Address do
  @moduledoc """
  An Ecto Type for plaintext addresses.
  Useful for publicly available addressses.
  See `Fields.AddressEncrypted` for storing addresses that are Personally Identifiable Information.

  ## Example

        schema "retailers" do
          field(:address, Fields.Address)
        end
  """

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
