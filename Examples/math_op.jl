using Random

function generate(num)
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
    shuffled_nums = Random.shuffle(nums)
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


numbers = generate(5000000)
exp_gen = exp(numbers, 2)
# dot_exp_gen = dot_exp(numbers, 2) # Same result as above, different code
arr1 = shuffle_nums(numbers)
arr2 = shuffle_nums(numbers)
unsorted_nums = list_multiplication(arr1, arr2)
sorted_nums = sort_nums(unsorted_nums)
println(sorted_nums)
