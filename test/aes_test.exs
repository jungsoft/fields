defmodule Fields.AESTest do
  use ExUnit.Case, async: true
  alias Fields.AES

  doctest Fields.AES

  describe "encrypt/1" do
    test "can encrypt a value" do
      assert AES.encrypt("hello") != "hello"
    end

    test "can encrypt a number" do
      assert is_binary(AES.encrypt(123))
    end

    test "includes the random IV in the value" do
      <<iv::binary-16, ciphertext::binary>> = AES.encrypt("hello")

      assert String.length(iv) != 0
      assert String.length(ciphertext) != 0
      assert is_binary(ciphertext)
    end

    test "does not produce the same ciphertext twice" do
      assert AES.encrypt("hello") != AES.encrypt("hello")
    end
  end


  describe "decrypt/1" do
    test "should be able to decrypt an encrypted value" do
      encrypted = AES.encrypt("hello")
      assert "hello" == AES.decrypt(encrypted)
    end

    test "should always be able to decrypt the values in the same way (no breaking changes)" do
      assert "hello" == AES.decrypt(<<218, 133, 236, 82, 188, 122, 211, 234, 87, 136, 176, 237, 177, 242, 146, 197, 50, 12, 46, 155, 216, 194, 208, 212, 151, 41, 2, 58, 223, 191, 104, 239, 201, 200, 59, 153, 13>>)
      assert "hello" == AES.decrypt(<<239, 90, 33, 103, 251, 139, 107, 43, 104, 130, 58, 80, 82, 91, 36, 10, 146, 128, 228, 81, 219, 77, 15, 186, 25, 9, 57, 220, 123, 25, 35, 39, 143, 47, 135, 171, 18>>)
      assert "hello" == AES.decrypt(<<57, 150, 193, 187, 183, 247, 135, 180, 141, 48, 215, 201, 159, 161, 48, 51, 109, 113, 13, 181, 213, 192, 89, 234, 20, 35, 202, 122, 149, 122, 224, 120, 215, 154, 81, 6, 218>>)
      assert "a" == AES.decrypt(<<158, 74, 33, 58, 229, 86, 143, 225, 207, 5, 183, 103, 100, 79, 204, 130, 152, 216, 110, 192, 131, 146, 157, 40, 222, 87, 164, 218, 1, 233, 46, 44, 84>>)
      assert "123" == AES.decrypt(<<183, 159, 168, 201, 131, 230, 188, 185, 240, 147, 212, 93, 18, 111, 88, 69, 160, 153, 190, 45, 144, 106, 67, 114, 218, 200, 253, 72, 243, 128, 86, 95, 124, 143, 121>>)
      assert "very long text that needs to be encrypted" == AES.decrypt(<<248, 227, 177, 27, 95, 70, 120, 48, 50, 31, 102, 219, 181, 213, 56, 187, 67, 46, 20, 208, 50, 137, 214, 40, 113, 248, 243, 47, 160, 172, 168, 3, 223, 109, 90, 167, 224, 111, 236, 207, 42, 197, 46, 91, 38, 83, 51, 129, 52, 253, 143, 193, 80, 228, 23, 108, 2, 184, 210, 84, 80, 191, 44, 85, 33, 116, 109, 136, 107, 113, 164, 12, 211>>)
    end
  end
end
