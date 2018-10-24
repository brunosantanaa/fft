defmodule FFT do
  @moduledoc """
  FFT - Fast Fourier Transform
  Algorithm for fast fourier transform, which is widely used in the treatment of signals.

  The fast fourier transform picks up the signal input in a given time period and divides it into its frequency components.

  """
  require Integer
  import :math
  
  @doc """
  Input list and return the fft-list.

  List (With length power of 2) -> Complex List

  ## Example

  ```
  iex> a = [1,1,1,1,0,0,0,0]
    [1, 1, 1, 1, 0, 0, 0, 0]
  iex> FFT.transform a
    [#ComplexNum (Cartesian) <4.0 + 0.0·𝑖>,
    #ComplexNum (Cartesian) <1.0 + -2.414213562373095·𝑖>,
    #ComplexNum (Cartesian) <0.0 + 0.0·𝑖>,
    #ComplexNum (Cartesian) <1.0 + -0.4142135623730949·𝑖>,
    #ComplexNum (Cartesian) <0.0 + 0.0·𝑖>,
    #ComplexNum (Cartesian) <0.9999999999999999 + 0.4142135623730949·𝑖>,
    #ComplexNum (Cartesian) <0.0 + 0.0·𝑖>,
    #ComplexNum (Cartesian) <0.9999999999999997 + 2.414213562373095·𝑖>]
  ```
  """
  def transform (a) do
    test_var = a |> length |> :math.log2
    if (test_var / round(test_var) == 1), do: solve(a), else: raise(ArgumentError, "The list length is not a power of 2.")
  end
  defp solve(a, i \\ -1, s \\ 1, k \\ 0, j \\ 1) do
    unless i >= (length(a)) || i == -1 do
      b = butterfly(Enum.at(a, i), Enum.at(a, i+1), k, pow(2, s))
      att_matrix = a |> List.update_at(i, &(&1 = Enum.at(b, 0))) 
                     |> List.update_at((i + 1), &(&1 = Enum.at(b, 1)))
      if j >= (length(a) / pow(2, s)), do: solve(att_matrix, i + 2, s, k + 1), else: solve(att_matrix, i + 2, s, k, j + 1)
    else
      if i == -1 do
        a |> bit_reverse |> solve(i + 1)
      else
        unless s >= log2(length(a)) do
          a |> even_odd |> solve(0, s + 1)
        else
          even_odd(a)
        end
      end
    end
  end
  @doc """
  Input a list and returns a list with the reassembled elements using bit-reverse.

  List -> List

  ## Example
  ```
  iex> a = [0, 1, 2, 3, 4, 5, 6, 7]
  [0, 1, 2, 3, 4, 5, 6, 7]
  iex> FFT.bit_reverse a
  [0, 4, 2, 6, 1, 5, 3, 7]
  ```
  """
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

  defp butterfly(h, g, k, n) do
    w = ComplexNum.new(1, (-2 * pi() * k / n), :polar)
    t = ComplexNum.mult(w, g)
    [ComplexNum.add(h, t), ComplexNum.sub(h, t)]
  end
  @doc """
  Returns vector where each is the modulus of the complexe number

  ## Example
  
  ```elixir
  iex>  a = [1, 0, 1, 0]
    [1, 0, 1, 0]
  iex> a = FFT.transform a
    [#ComplexNum (Cartesian) <2.0 + 0.0·𝑖>,
    #ComplexNum (Cartesian) <0.0 + 0.0·𝑖>,
    #ComplexNum (Cartesian) <2.0 + 0.0·𝑖>,
    #ComplexNum (Cartesian) <0.0 + 0.0·𝑖>]
  iex> FFT.modulus_vector a
    [2.0, 0.0, 2.0, 0.0]
  ```
  """
  def modulus_vector(a) do
    Enum.map(a, fn x -> ComplexNum.magnitude(x) end )
  end
  defp zeros(bin, a) do
    len = length(bin)
    unless len == :math.log2(length(a)), do: zeros([0] ++ bin, a), else: bin
  end
  defp inverter(bin, resp \\[]) do
    [h | t] = bin
    unless t == [], do: inverter(t, [h] ++ resp), else: [h] ++ resp
  end
  defp even_odd(a, rec \\ -1, e \\ [], o \\ [], n \\ 0) do
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
