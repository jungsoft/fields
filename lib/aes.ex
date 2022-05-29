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
  ciphertext. This means that `encrypt/1` will never return the same ciphertext
  for the same value. This makes "cracking" (bruteforce decryption) much harder!

  ## Parameters
  - `plaintext`: Accepts any data type as all values are converted to a String
    using `to_string/1` before encryption.

  ## Examples
      iex> Fields.AES.encrypt("tea") != Fields.AES.encrypt("tea")
      true

      iex> ciphertext = Fields.AES.encrypt(123)
      iex> is_binary(ciphertext)
      true
  """
  @spec encrypt(any) :: String.t
  def encrypt(plaintext) do
    iv = :crypto.strong_rand_bytes(16) # create random Initialisation Vector
    {ciphertext, tag} = :crypto.crypto_one_time_aead(:aes_256_gcm, get_key(), iv, to_string(plaintext), @aad, true)
    iv <> tag <> ciphertext # "return" iv with the cipher tag & ciphertext
  end

  @doc """
  Decrypt a binary using GCM.

  ## Parameters
  - `ciphertext`: a binary to decrypt, assuming that the first 16 bytes of the
    binary are the IV to use for decryption.

  ## Examples
      iex> Fields.AES.encrypt("test") |> Fields.AES.decrypt()
      "test"
  """
  @spec decrypt(any) :: String.t
  def decrypt(ciphertext) do
    <<iv::binary-16, tag::binary-16, ciphertext::binary>> = ciphertext
    :crypto.crypto_one_time_aead(:aes_256_gcm, get_key(), iv, ciphertext, @aad, tag, false)
  end

  defp get_key do
    Application.get_env(:fields, Fields.AES)[:key]
  end
end
