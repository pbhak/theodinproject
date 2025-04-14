def fibs(n)
  base_arr = [0, 1]
  return base_arr[0..n] if n < 2

  (n - 2).times do
    base_arr << base_arr[-2] + base_arr[-1]
  end

  base_arr
end

def fibs_rec(n)
  return [0] if n.zero?
  return [0, 1] if n == 1

  arr = fibs_rec(n - 1)

  arr + [arr[n - 1] + arr[n - 2]]
end

p fibs 8
p fibs_rec 7
