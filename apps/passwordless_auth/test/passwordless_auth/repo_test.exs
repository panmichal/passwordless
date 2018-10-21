defmodule PasswordlessAuth.RepoTest do
  use ExUnit.Case, async: true

  alias PasswordlessAuth.Repo

  describe ".init/1" do
    test "returns error when emails are wrong" do
      Process.flag(:trap_exit, true)

      name = :repo_test_1
      Repo.start_link(name: name, emails: "")

      assert_receive {:EXIT, _, "Invalid list of emails"}
    end

    test "starts the repo when emails is a list" do
      name = :repo_test_2
      assert {:ok, _pid} = Repo.start_link(name: name, emails: ["foo@email.com"])
    end
  end

  describe ".exists/2" do
    test "returns true if email exists in the state" do
      email = "foo@example.com"
      name = :repo_test_3
      {:ok, _pid} = Repo.start_link(name: name, emails: [email])

      assert Repo.exists?(name, email)
    end

    test "returns false if email does not exist in the state" do
      email = "foo@example.com"
      name = :repo_test_4
      {:ok, _pid} = Repo.start_link(name: name, emails: [email])

      refute Repo.exists?(name, "non_existing@example.com") 
    end
  end

  describe ".save/3" do
    test "stores token in the state if email exists" do
      email = "foo@example.com"
      token = "sometoken"
      name = :repo_test_5
      {:ok, _pid} = Repo.start_link(name: name, emails: [email])

      assert :ok = Repo.save(name, email, token)
      assert ^token = Map.get(:sys.get_state(name), email)
    end

    test "returns error when email does not exist" do
      email = "foo@example.com"
      token = "sometoken"
      name = :repo_test_5
      {:ok, _pid} = Repo.start_link(name: name, emails: [email])

      assert {:error, :invalid_email} = Repo.save(name, "nonexisting@example.com", token)
    end
    
    
  end
  
  
end