defmodule BinaryUtils do
  def find_set_bits(int) when is_integer(int) do
    bin = :binary.encode_unsigned(int)
    find_set_bits(bin)
  end

  def find_set_bits(bin, idx \\ 1) when is_binary(bin) or is_bitstring(bin),
    do: find_set_bits_(bin, idx, [])

  defp find_set_bits_(<<>>, _idx, acc), do: acc

  defp find_set_bits_(<<1::integer-size(1), rest::bitstring>>, idx, acc),
    do: find_set_bits_(rest, idx + 1, [idx | acc])

  defp find_set_bits_(<<_::integer-size(1), rest::bitstring>>, idx, acc),
    do: find_set_bits_(rest, idx + 1, acc)
end
