defmodule Fields.EctoValidator do
  @moduledoc """
  Validator for Ecto
  """
  import Ecto.Changeset
  alias Fields.Validate

  @doc """
  Validate Ecto changeset. Returns changeset
  ## Examples
      defmodule User do
        use Ecto.Schema
        use Ecto.Model
        schema "users" do
          field :email, :string
        end
        def changeset(user, params \\ :empty) do
          user
          |> cast(params, ~w(email), ~w())
          |> Fields.EctoValidator.validate_email_plain_text(:email)
        end
      end
  """
  def validate_email(changeset, field, opts \\ []) do
    message = Keyword.get(opts, :message, "has invalid format")

    changeset
    |> get_field(field)
    |> Validate.email()
    |> case do
      true -> changeset
      false -> add_error(changeset, field, message)
    end
  end

  def validate_url(changeset, field, opts \\ []) do
    message = Keyword.get(opts, :message, "has invalid format")

    changeset
    |> get_field(field)
    |> Validate.url()
    |> case do
      true -> changeset
      false -> add_error(changeset, field, message)
    end
  end

  def validate_address(changeset, field, opts \\ []) do
    message = Keyword.get(opts, :message, "has invalid format")

    changeset
    |> get_field(field)
    |> Validate.address()
    |> case do
      true -> changeset
      false -> add_error(changeset, field, message)
    end
  end

  def validate_phone_number(changeset, field, opts \\ []) do
    message = Keyword.get(opts, :message, "has invalid format")

    changeset
    |> get_field(field)
    |> Validate.phone_number()
    |> case do
      true -> changeset
      false -> add_error(changeset, field, message)
    end
  end

  def validate_postcode(changeset, field, opts \\ []) do
    message = Keyword.get(opts, :message, "has invalid format")

    changeset
    |> get_field(field)
    |> Validate.postcode()
    |> case do
      true -> changeset
      false -> add_error(changeset, field, message)
    end
  end
end
