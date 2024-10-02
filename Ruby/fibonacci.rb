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