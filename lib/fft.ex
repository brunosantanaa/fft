defmodule FFT do
  @moduledoc """
  Documentation for FFT.
  """
  require Integer
  import :math

  def solve(a, i \\ -1, s \\ 1, k \\ 0, j \\ 0) do
    unless i >= (length(a)) || i == -1 do
      if (pow(2, s) + j - 1) > (length(a) / 2) do
        b = butterfly(Enum.at(a, i), Enum.at(a, i+1), k, pow(2, s))
        
        a |> List.update_at(i, &(&1 = Enum.at(b, 0)))
          |> List.update_at((i + 1), &(&1 = Enum.at(b, 1)))
          |> solve(i + 2, s, k + 1)
      else
        b = butterfly(Enum.at(a, i), Enum.at(a, i + 1), k, pow(2, s))

        a |> List.update_at(i, &(&1 = Enum.at(b, 0))) 
          |> List.update_at((i + 1), &(&1 = Enum.at(b, 1)))
          |> solve(i + 2, s, k, j + 1)
      end
    else
      if i == -1 do
        a |> bit_reverse |> solve(i + 1)
      else
        unless s >= log2(length(a))do
          a |> even_odd |> solve(0, s + 1)
        else
          even_odd(a)
        end
      end
    end
  end

  def butterfly(h, g, k, n) do
    w = ComplexNum.new(1, (-2 * pi() * k / n), :polar)
    t = ComplexNum.mult(w, g)
    [ComplexNum.add(h, t), ComplexNum.sub(h, t)]
  end

  def modulus_vector(a) do
    Enum.map(a, fn x -> ComplexNum.magnitude(x) end )
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
  def even_odd(a, rec \\ -1, e \\ [], o \\ [], n \\ 0) do
    unless n >= length(a) do
      if Integer.is_even(n), 
        do: even_odd(a, rec, e ++ [Enum.at(a, n)], o ,n + 1), else: even_odd(a,rec , e, o ++ [Enum.at(a, n)],n + 1)
    else
      if rec > 0 do
        even_odd(e++o, rec - 1)
      else
        e++o
      end
    end
  end
end
