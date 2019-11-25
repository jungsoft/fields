defmodule Fields.EmailPlaintext do
  @moduledoc """
  An Ecto Type for plaintext emails.
  Useful for publicly available email addressses such as customer support emails.
  See `Fields.EmailEncrypted` and `Fields.EmailHash` for storing user email addresses.

  ## Example

        schema "retailers" do
          field(:email, Fields.EmailPlaintext)
        end
  """
  alias Fields.Validate

  @behaviour Ecto.Type

  def type, do: :string

  def cast(value) do
    value = value |> to_string() |> String.downcase() |> String.trim()
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
