//
//  main.swift
//  CharlieTheDog
//
//  Created by Khushneet Inder Singh on 8/25/21.
//

import Foundation

//https://coderbyte.com/solution/Charlie%20the%20Dog

func CharlietheDog(_ strArr: [String]) -> String
{
	// Method to find all permutation of paths
	func permutaion(_ a: [String], _ n: Int, _ f: inout [[String]]) {
		if n == 0 {
			f.append(a)
		} else {
			var a = a
			permutaion(a, n - 1, &f)
			for i in 0..<n {
				a.swapAt(i, n)
				permutaion(a, n - 1, &f)
				a.swapAt(i, n)
			}
		}
	}
	
	// Calculate the minimum distance needs to cover after traversing all nodes
	func minDistance(_ matrix:[[Character]]) -> String
	{
		struct Position {
			var row = 0
			var col = 0
		}
		var charliePosition = Position(row: 0, col: 0)
		var homePosition = Position(row: 0, col: 0)
		var positionInfo : [Position] = []
		
		for (rIndex, row) in matrix.enumerated() {
			for (cIndex, col) in row.enumerated() {
				switch col {
				case "C":
					charliePosition.row = rIndex
					charliePosition.col = cIndex
				case "H":
					homePosition.row = rIndex
					homePosition.col = cIndex
				case "F":
					positionInfo.append(Position(row: rIndex, col: cIndex))
				default:
					break
				}
			}
		}
		positionInfo.insert(charliePosition, at: 0)
		positionInfo.append(homePosition)
		// Till now the postion will be C, F1, F2, F3, ... , H
		
		// Build look up matrix with the distance between two nodes
		var lookupMatrix = [[Int]]()
		for (rIndex, _) in positionInfo.enumerated() {
			var list : [Int] = []
			for (cIndex, _) in positionInfo.enumerated() {
				var val = abs(positionInfo[rIndex].row - positionInfo[cIndex].row) + abs(positionInfo[rIndex].col - positionInfo[cIndex].col)
				if ((rIndex == 0 && cIndex == positionInfo.count - 1)
					|| (rIndex == positionInfo.count - 1 && cIndex == 0))
				{
					val = 0
				}
				list.append(val)
			}
			lookupMatrix.append(list)
		}
		
		var foodIndex = [String]()
		for i in 1...positionInfo.count - 2 {
			foodIndex.append(String(i))
		}
		
		var foodCombination = [[String]]()
		permutaion(foodIndex, foodIndex.count - 1, &foodCombination)
		var allDistances = [Int]()
		for (_, combination) in foodCombination.enumerated() {
			var distance = 0
			var comb = combination
			comb.insert(String(0), at: 0) // Charlie position
			comb.append(String(4))        // Home position
			
			for index in 0..<comb.count - 1{
				let node1 = Int(comb[index])!;
				let node2 = Int(comb[index+1])!;
				let value = lookupMatrix[node1][node2]
				distance = distance + value
			}
			
			allDistances.append(distance)
		}
		
		return String(allDistances.min()!)
	}
	let matrix  = strArr.map{$0.map{$0}}
	return minDistance(matrix)
}

print(CharlietheDog(["OOOO", "OOFF", "OCHO", "OFOO"]));
