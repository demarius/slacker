defmodule Slacker.Habit do
  defstruct name: "", count: 0, description: ""

  @range_start = 1
  @range_end = 20

  def random do
    Enum.random(
      [
        %Slacker.Habit{
          name: :meditate,
          count: Enum.random(Range.new(@range_start, @range_end)),
          description: 'just do it'
        },
        %Slacker.Habit{
          name: :exercise,
          count: Enum.random(Range.new(@range_start, @range_end)),
          description: 'just do it'
        }
      ]
    )
  end
end
