<<<<<<< HEAD
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

puts "fibs_rec and fibs have same output: #{fibs(8) == fibs_rec(7)} "
=======
def fibs(num)
  arr = [0]
  return if num == 0
  return arr if num == 1

  (num - 1).times do
    if arr[-1].zero?
    arr << 1 
    else
    arr << (arr[-1] + arr[-2])
    end
  end

  return arr
end
  
def fibs_rec(num)
  return [0] if num == 0
  return [0, 1] if num == 1
  
  arr = fibs_rec(num - 1)
  arr << arr[-1] + arr[-2]
end

p fibs_rec(7) # Expected - [0, 1, 1, 2, 3, 5, 8, 13] (array with length 8)
p fibs 8
>>>>>>> b8fbaddcfe9273c1e6cd6f00a4eb0333b09fbb9f
