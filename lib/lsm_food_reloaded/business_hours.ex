defmodule LsmFoodReloaded.BusinessHours do
  @moduledoc """
  The BusinessHours context.
  """

  import Ecto.Query, warn: false
  alias LsmFoodReloaded.Repo

  alias LsmFoodReloaded.BusinessHours.BussinessHour

  @doc """
  Returns the list of business_hours.

  ## Examples

      iex> list_business_hours()
      [%BussinessHour{}, ...]

  """
  def list_business_hours do
    Repo.all(BussinessHour)
  end

  @doc """
  Gets a single bussiness_hour.

  Raises `Ecto.NoResultsError` if the Bussiness hour does not exist.

  ## Examples

      iex> get_bussiness_hour!(123)
      %BussinessHour{}

      iex> get_bussiness_hour!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bussiness_hour!(id), do: Repo.get!(BussinessHour, id)

  @doc """
  Creates a bussiness_hour.

  ## Examples

      iex> create_bussiness_hour(%{field: value})
      {:ok, %BussinessHour{}}

      iex> create_bussiness_hour(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bussiness_hour(attrs \\ %{}) do
    %BussinessHour{}
    |> BussinessHour.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bussiness_hour.

  ## Examples

      iex> update_bussiness_hour(bussiness_hour, %{field: new_value})
      {:ok, %BussinessHour{}}

      iex> update_bussiness_hour(bussiness_hour, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bussiness_hour(%BussinessHour{} = bussiness_hour, attrs) do
    bussiness_hour
    |> BussinessHour.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bussiness_hour.

  ## Examples

      iex> delete_bussiness_hour(bussiness_hour)
      {:ok, %BussinessHour{}}

      iex> delete_bussiness_hour(bussiness_hour)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bussiness_hour(%BussinessHour{} = bussiness_hour) do
    Repo.delete(bussiness_hour)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bussiness_hour changes.

  ## Examples

      iex> change_bussiness_hour(bussiness_hour)
      %Ecto.Changeset{data: %BussinessHour{}}

  """
  def change_bussiness_hour(%BussinessHour{} = bussiness_hour, attrs \\ %{}) do
    BussinessHour.changeset(bussiness_hour, attrs)
  end
end
