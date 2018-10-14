defmodule FFT do
  @moduledoc """
  Documentation for FFT.
  """

  def w_complex(m, x) do
    n = - :math.pi * x/ m
    ComplexNum.new(1, n, :polar)
  end
  
  def bit_reverse(array, reverse \\ [], n \\ 0) do
    unless n == length(array) do
      ind = n |> Integer.digits(2)
              |> zeros(array)
              |> inverter
              |> Integer.undigits(2)
      bit_reverse(array, reverse ++ [Enum.at(array, ind)], n + 1)
    else
      reverse
    end
  end
  defp zeros(bin, a) do
    len = length(bin)
    unless len == :math.log2(length(a)), do: zeros([0] ++ bin, a), else: bin
  end
  defp inverter(bin, resp \\[]) do
    [h | t] = bin
    unless t == [], do: inverter(t, [h] ++ resp), else: [h] ++ resp
  end
end
