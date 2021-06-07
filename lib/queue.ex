defmodule Queue do
  use GenServer

  def start_link(initial_stack \\ []) when is_list(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack)
  end

  def enqueue(pid, element) do
    GenServer.cast(pid, {:push, element})
  end

  def dequeue(pid) do
    GenServer.call(pid, :pop)
  end

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  @impl true
  def handle_cast({:push, element}, stack) do
    {:noreply, [element | stack]}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_call(:pop, _from, []) do
    {:reply, nil, []}
  end
end
