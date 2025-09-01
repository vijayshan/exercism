defmodule BankAccount do
  use GenServer

  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = GenServer.start(__MODULE__, 0)
    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.stop(account, :normal, 100)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    try do
      GenServer.call(account, {:balance})
    catch
      :exit, {:noproc, _} -> {:error, :account_closed}
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    try do
      GenServer.call(account, {:update, amount})
    catch
      :exit, {:noproc, _} -> {:error, :account_closed}
    end
  end

  def init(balance) do
    {:ok, balance}
  end

  def handle_call({:update, amount}, _, balance) do
    {:reply, balance + amount, balance + amount}
  end

  def handle_call({:balance}, _, balance) do
    {:reply, balance, balance}
  end
end
