function solve_line(nums)

  full = gen_map(nums)
  l = length(full[1])
  display(full)
  sum(full[:,length(full[1,:])])
end

function gen_map(nums)
  c = init_pyramid(nums)

# [1,2,3]
# [0,1,1]

  for i in 2:length(nums)
    c = add_row(c)
    for j in i:length(nums)
      intermediate = c[i-1,j] - c[i-1,j-1]
      c[i,j] = intermediate
    end
  end

  c
end

function gen_map2(nums)
  c = init_pyramid(nums)

# [1,2,3]
# [1,1,0]

  for i in 2:length(nums)
    c = add_row(c)
    for j in 1:length(nums)-i+1
      intermediate = c[i-1,j+1] - c[i-1,j]
      c[i,j] = intermediate
    end
  end

  c
end

function solve_line2(nums)
  full = gen_map2(nums)
  display(full)
  left = full[:,1]
  lefter = zeros(Int, length(full))
  carry = 0
  for i in 1:length(left)
    ii = 1 + length(left) - i
    carry = left[i] - carry
  end
  carry
end

function init_pyramid(nums)
  c = nums
  z = zeros(Int, 1, length(nums))
  c = vcat(z);
  for i in 1:length(nums)
    c[1,i] = nums[i]
  end
  c
end

function add_row(pyr)
  vcat(
    pyr,
    zeros(Int, 1, length(pyr[1,:]))
  )
end



function main()


  println(@__DIR__)
  path = joinpath(@__DIR__, "input")
  #path = joinpath(@__DIR__, "example")

  # read entire file into a string
  contents = read(path, String)
  lines = filter(line -> length(line) > 0, collect(eachsplit(contents, "\n")))
  lines = map(line -> collect(eachsplit(line, " ")), lines)
  lines = map(line -> map(str -> parse(Int, str), line), lines)


  #solutions = map(line -> solve_line(line), lines)
  solutions = map(line -> solve_line2(line), lines)

  println(solutions)
  println("HOla")
  println(solutions)
  println(sum(solutions))
  println("HOla")
end

main()
