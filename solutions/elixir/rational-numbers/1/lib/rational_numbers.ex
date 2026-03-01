defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, b1}, {a2, b2}), do: reduce({a1 * b2 + a2 * b1, b1 * b2})

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, b1}, {a2, b2}), do: add({a1, b1}, {-a2, b2})


  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, b1}, {a2, b2}), do: reduce({a1 * a2, b1 * b2})

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, b1}, {a2, b2}), do: reduce({a1 * b2, a2 * b1})

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({a, b}), do: reduce({Kernel.abs(a), Kernel.abs(b)})

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a, b}, n) when n > 0, do: {a ** n, b ** n}
  def pow_rational({a, b}, n), do: reduce({b ** Kernel.abs(n), a ** Kernel.abs(n)})

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a, b}), do: x ** (a / b)

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({a, b}) do
    gcd = gcd(a, b)
    {res_a, res_b} = {a / gcd, b / gcd}
    cond do
      res_a >= 0 and res_b <= 0 -> {res_a * -1, res_b * -1}
      res_a < 0 and res_b < 0 -> {res_a * -1, res_b * -1}
      true -> {res_a, res_b}
    end
  end

  @spec gcd(a :: integer, b :: integer) :: integer
  defp gcd(a, b) when b == 0, do: a
  defp gcd(a, b), do: gcd(b, rem(a, b))

end
