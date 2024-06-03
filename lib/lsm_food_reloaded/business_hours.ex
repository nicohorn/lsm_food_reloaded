defmodule LsmFoodReloaded.BusinessHours do
  @moduledoc """
  The BusinessHours context.
  """

  import Ecto.Query, warn: false
  alias LsmFoodReloaded.Repo

  alias LsmFoodReloaded.BusinessHours.BusinessHour

  @doc """
  Returns the list of business_hours.

  ## Examples

      iex> list_business_hours()
      [%BusinessHour{}, ...]

  """
  def list_business_hours do
    Repo.all(BusinessHour)
  end

  @doc """
  Gets a single business_hour.

  Raises `Ecto.NoResultsError` if the Business hour does not exist.

  ## Examples

      iex> get_business_hour!(123)
      %BusinessHour{}

      iex> get_business_hour!(456)
      ** (Ecto.NoResultsError)

  """
  def get_business_hour!(id), do: Repo.get!(BusinessHour, id)

  @doc """
  Creates a business_hour.

  ## Examples

      iex> create_business_hour(%{field: value})
      {:ok, %BusinessHour{}}

      iex> create_business_hour(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_business_hour(attrs \\ %{}) do
    %BusinessHour{}
    |> BusinessHour.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a business_hour.

  ## Examples

      iex> update_business_hour(business_hour, %{field: new_value})
      {:ok, %BusinessHour{}}

      iex> update_business_hour(business_hour, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_business_hour(%BusinessHour{} = business_hour, attrs) do
    business_hour
    |> BusinessHour.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a business_hour.

  ## Examples

      iex> delete_business_hour(business_hour)
      {:ok, %BusinessHour{}}

      iex> delete_business_hour(business_hour)
      {:error, %Ecto.Changeset{}}

  """
  def delete_business_hour(%BusinessHour{} = business_hour) do
    Repo.delete(business_hour)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking business_hour changes.

  ## Examples

      iex> change_business_hour(business_hour)
      %Ecto.Changeset{data: %BusinessHour{}}

  """
  def change_business_hour(%BusinessHour{} = business_hour, attrs \\ %{}) do
    BusinessHour.changeset(business_hour, attrs)
  end
end
