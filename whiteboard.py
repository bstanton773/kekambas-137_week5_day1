# Given an array nums, write a function to move all 0's to the end of it 
# while maintaining the relative order of the non-zero elements.
# Example:
# Input: [0,1,0,3,12]
# Output: [1,3,12,0,0]
# Example Input: [0,0,11,2,3,4]
# Example Output: [11,2,3,4,0,0]

def solution(nums): # O(n*n)
    zeros = 0 # O(1)
    while 0 in nums: # O(n)
        nums.remove(0) # O(n)
        zeros += 1 # O(1)
    nums = nums + ([0] * zeros) # O(n)
    return nums # O(1)


def solution(nums): # O(n)
    output = [] # O(1)
    zero_count = 0 # O(1)
    for num in nums: # O(n)
        if num == 0: # O(1)
            zero_count += 1 # O(1)
        else:
            output.append(num) # O(1)
    for _ in range(zero_count): # O(n)
        output.append(0) # O(1)
    return output # O(1)

solution([0,1,0,3,12])

def solution(nums):
    nums.sort(key=lambda num: not num)
    return nums
