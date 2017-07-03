//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
func averageOf(nums: [Int]) -> (Int){
    
    var sum = 0
    let count = nums.count
    
    
    for num in nums {
        sum += num
    }
    
    let averages = sum / count
    
    
    return sum
}
let averageq = averageOf(nums: [25, 30, 29])