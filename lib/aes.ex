defmodule Fields.AES do
  @moduledoc """
  Encrypt values with AES in Galois/Counter Mode (GCM)
  https://en.wikipedia.org/wiki/Galois/Counter_Mode
  using a random Initialisation Vector for each encryption,
  this makes "bruteforce" decryption much more difficult.
  See `encrypt/1` and `decrypt/1` for more details.
  """
  # Use AES 256 Bit Keys for AES.
  @aad "AES256GCM"

  @doc """
  Uses a random IV for each call, and prepends the IV and Tag to the
  ciphertext.  This means that `encrypt/1` will never return the same ciphertext
  for the same value. This makes "cracking" (bruteforce decryption) much harder!
  ## Parameters
  - `plaintext`: Accepts any data type as all values are converted to a String
    using `to_string` before encryption.
  ## Examples
      iex> Fields.AES.encrypt("tea") != Fields.AES.encrypt("tea")
      true
      iex> ciphertext = Fields.AES.encrypt(123)
      iex> is_binary(ciphertext)
      true
  """
  @spec encrypt(any, String.t() | nil) :: String.t
  def encrypt(plaintext, key_id \\ nil) do
    iv = :crypto.strong_rand_bytes(16) # create random Initialisation Vector
    {ciphertext, tag} = :crypto.block_encrypt(:aes_gcm, get_key(key_id), iv, {@aad, to_string(plaintext), 16})
    iv <> tag <> ciphertext # "return" iv with the cipher tag & ciphertext
  end

  @doc """
  Decrypt a binary using GCM.
  ## Parameters
  - `ciphertext`: a binary to decrypt, assuming that the first 16 bytes of the
    binary are the IV to use for decryption.
  ## Example
      iex> Fields.AES.encrypt("test") |> Fields.AES.decrypt()
      "test"
  """
  @spec decrypt(any, String.t() | nil) :: String.t
  def decrypt(ciphertext, key_id \\ nil) do
    <<iv::binary-16, tag::binary-16, ciphertext::binary>> = ciphertext
    :crypto.block_decrypt(:aes_gcm, get_key(key_id), iv, {@aad, ciphertext, tag})
  end

  # @doc """
  # get_key - Get encryption key from list of keys.
  # if `key_id` is *not* supplied as argument,
  # then the default *latest* encryption key will be returned.
  # ## Parameters
  # - `key_id`: the index of AES encryption key used to encrypt the ciphertext
  # ## Example
  #     iex> Fields.AES.get_key
  #     <<13, 217, 61, 143, 87, 215, 35, 162, 183, 151, 179, 205, 37, 148>>
  # """ # doc commented out because https://stackoverflow.com/q/45171024/1148249
  @spec get_key(number | nil) :: String
  defp get_key(nil) do
    Application.get_env(:fields, Fields.AES)[:keys]
    |> List.last()
  end

  defp get_key(key_id) do
    keys = Application.get_env(:fields, Fields.AES)[:keys]
    Enum.at(keys, key_id)
  end
end
