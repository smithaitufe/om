defmodule Store.Helper.Session do
  alias Store.{Repo, User}
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  def authenticate(%{"id" => id, "password" => password}) do
    user = case Repo.get_by(User, email: String.downcase(id)) do
      nil -> Repo.get_by(User, phone_number: String.downcase(id))
      user -> user
    end
    case check_password(user, password) do
      true -> {:ok, user}
      _ -> {:error, :unsuccessful}
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> dummy_checkpw()
      _ -> checkpw(password, user.hashed_password)
    end
  end
end
