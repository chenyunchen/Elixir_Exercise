defmodule Counter do
  def start_run do
    Agent.start(fn -> %{total: 0, agree: 0, disagree: 0} end, name: :opinions)
  end

  def record_agree do
    Agent.update(:opinions, fn %{total: t, agree: a, disagree: d} ->
      %{total: t + 1, agree: a + 1, disagree: d}
    end)
  end

  def record_disagree do
    Agent.update(:opinions, fn %{total: t, agree: a, disagree: d} ->
      %{total: t + 1, agree: a, disagree: d + 1}
    end)
  end

  def report_results do
    Agent.get(:opinions, &(&1))
  end
end
