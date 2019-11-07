defmodule Fields.AddressEncrypted do
  @moduledoc """
  An Ecto Type for encrypted addresses.

  ## Example

      schema "users" do
        field(:address, Fields.AddressEncrypted)
      end
  """
  alias Fields.{Address, Encrypted}

  @behaviour Ecto.Type

  def type, do: :binary

  def cast(value), do: Address.cast(value)

  def dump(value), do: Encrypted.dump(value)

  def load(value), do: Encrypted.load(value)

  def embed_as(_value), do: :dump

  def equal?(a, b), do: a == b
end
