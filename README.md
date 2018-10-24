# FFT

Algorithm for fast fourier transform, which is widely used in the treatment of signals.

The fast fourier transform picks up the signal input in a given time period and divides it into its frequency components as in the following figure:

![imagem](https://upload.wikimedia.org/wikipedia/commons/6/64/FFT_of_Cosine_Summation_Function.png)

## Example

```elixir
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
## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `fft` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:fft, "~> 0.1.2"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/fft](https://hexdocs.pm/fft).