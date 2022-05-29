defmodule Fields.EctoValidatorTest do
  use ExUnit.Case, async: true

  alias Fields.EctoValidator

  describe "validate_email" do
    test "should is valid changeset if email is nil" do
      assert %Ecto.Changeset{valid?: true} = %{email: nil} |> Fields.User.changeset() |> EctoValidator.validate_email(:email)
    end

    test "should is invalid changeset if email is wrong" do
      assert %Ecto.Changeset{valid?: false} = %{email: "wrong"} |> Fields.User.changeset() |> EctoValidator.validate_email(:email)
    end

    test "should is valid changeset if email is correct format" do
      assert %Ecto.Changeset{valid?: true} = %{email: "correct@format.com"} |> Fields.User.changeset() |> EctoValidator.validate_email(:email)
    end
  end

  describe "validate_url" do
    test "should is valid changeset if url is nil" do
      assert %Ecto.Changeset{valid?: true} = %{url: nil} |> Fields.User.changeset() |> EctoValidator.validate_url(:url)
    end

    test "should is invalid changeset if url is wrong" do
      assert %Ecto.Changeset{valid?: false} = %{url: "asd/wrong.net"} |> Fields.User.changeset() |> EctoValidator.validate_url(:url)
    end

    test "should is valid changeset if url is correct format" do
      assert %Ecto.Changeset{valid?: true} = %{url: "https://example.net"} |> Fields.User.changeset() |> EctoValidator.validate_url(:url)
    end
  end

  describe "validate_phone_number" do
    test "should is valid changeset if phone_number is nil" do
      assert %Ecto.Changeset{valid?: true} = %{phone_number: nil} |> Fields.User.changeset() |> EctoValidator.validate_phone_number(:phone_number)
    end

    test "should is invalid changeset if phone_number is wrong" do
      assert %Ecto.Changeset{valid?: false} = %{phone_number: "9874654"} |> Fields.User.changeset() |> EctoValidator.validate_phone_number(:phone_number)
    end

    test "should is valid changeset if phone_number is correct format" do
      assert %Ecto.Changeset{valid?: true} = %{phone_number: "+449965555558"} |> Fields.User.changeset() |> EctoValidator.validate_phone_number(:phone_number)
    end
  end

  describe "validate_postcode" do
    test "should is valid changeset if postcode is nil" do
      assert %Ecto.Changeset{valid?: true} = %{postcode: nil} |> Fields.User.changeset() |> EctoValidator.validate_postcode(:postcode)
    end

    test "should is invalid changeset if postcode is wrong" do
      assert %Ecto.Changeset{valid?: false} = %{postcode: "9874654"} |> Fields.User.changeset() |> EctoValidator.validate_postcode(:postcode)
    end

    test "should is valid changeset if postcode is correct format" do
      assert %Ecto.Changeset{valid?: true} = %{postcode: "AA9A 9AA"} |> Fields.User.changeset() |> EctoValidator.validate_postcode(:postcode)
    end
  end
end
