# println("Hello SNLP Students!")

# type declarations on global variables are not yet supported. So we have to use it in things like functions
# You can do variable declaration but not in the global scope; these are the constructs in Julia that introduce a new scope:
# function show_name()
#     name::String = "Erfan"
#     return name
# end

# show_name()


function gen(num)
    numbers = []
    i = 1
    @time while size(numbers)[1] < num
        append!(numbers, i)
        i += 1
    end
    return numbers
end

function exp(nums, exp)
    exp_numbers = []
    @time for item in nums
        append!(exp_numbers, item^exp)
    end
    return exp_numbers
end

function dot_exp(nums, exp)
    return @time nums.^exp
end

function shuffle_nums(nums)
    shuffled_nums = shuffle(nums)
    return shuffled_nums
end

function sort_nums(nums)
    @time sort!(nums, alg = QuickSort)
    return nums
end

function list_multiplication(a, b)
    @time res = a .* b
    return res
end


# numbers = gen(5000000)
# exp_gen = exp(numbers, 2)
# dot_exp_gen = dot_exp(numbers, 2)
# arr1 = shuffle_nums(numbers)
# arr2 = shuffle_nums(numbers)
# list_multiplication(arr1, arr2)
# sort_nums(unsorted_nums)
# You generally want to use isa and <: for testing types, not == (for exact equality)
# Use roundings in numbers
# Use casting and conversion in numbers
# Numeric Literal Coefficients: for example Julia allows using variables as Coefficients like x=3, 2^2x results in 64
# String methods to use: https://docs.julialang.org/en/v1/manual/strings/#Common-Operations-1

# from above this link, use materials for mathematics section: https://docs.julialang.org/en/v1/manual/mathematical-operations/#Chaining-comparisons-1
