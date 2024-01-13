defmodule Sieve do
  def new(size) do
    <<-1::size(size)>>
  end

  def count_primes(<<>>, count), do: count

  def count_primes(<<bit::size(1), rest::bits>>, count) do
    count_primes(rest, count + bit)
  end

  def next_bit(bits, idx) do
    case bits do
      <<_::size(idx), 1::size(1), _::bits>> -> idx
      _ -> next_bit(bits, idx + 1)
    end
  end

  def set_bit(b, idx) do
    case b do
      <<_::size(idx), 0::size(1), _::bits>> ->
        b

      <<pre::size(idx), 1::size(1), post::bits>> ->
        <<pre::size(idx), 0::size(1), post::bits>>
    end
  end

  def run(size, bits, factor, idx) do
    q = (size / 2) |> :math.sqrt() |> Kernel.+(1)

    if idx < size do
      run(
        size,
        set_bit(bits, idx),
        factor,
        2 * factor + 1 + idx
      )
    else
      if factor < q do
        factor = factor + 1
        factor = next_bit(bits, factor)
        run(size, bits, factor, 2 * factor * (factor + 1))
      else
        bits
      end
    end
  end
end

arg = Enum.at(System.argv(), 0)
start = Time.utc_now()
{limit, _} = Integer.parse(arg)
size = div(limit + 1, 2)
sieve = Sieve.new(size)
bits = Sieve.run(size, sieve, 1, 4)
time = Time.diff(Time.utc_now(), start, :microsecond) / 1_000_000
count = Sieve.count_primes(bits, 0)
IO.puts("Elixir        -- Duration: #{time} -- Count: #{count}\n")
