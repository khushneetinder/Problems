//
//  main.swift
//  GasStation
//
//  Created by Khushneet Inder Singh on 8/25/21.
//

import Foundation

//https://leetcode.com/problems/gas-station/

func GasStation(_ strArr: [String]) -> String {
	var minimumFuel = "Impossible"
	var list : [Int] = []
	var impossible = false
	var startingPos = -1
	
	let numOfStations : Int = Int(strArr.first!)!
	let stations : [String] = Array(strArr.suffix(from: 1))
	
	
	for i in 0..<numOfStations {
		var totalFuel = 0
		startingPos = i
		
		for j in 0..<numOfStations {
			let magic = (j + i) % numOfStations
			let curSegment = stations[magic].components(separatedBy: ":")
			var fuel : Int = Int(curSegment[0])!
			let remainingFuel : Int = Int(curSegment[1])!
			
			fuel = fuel + totalFuel
			
			if (fuel < remainingFuel) {
				impossible = true
				break
			}
			
			totalFuel = fuel - remainingFuel
			impossible = false
		}
		
		if (!impossible) {
			list.append(startingPos)
		}
	}
	

	if list.count > 0 {
		minimumFuel = String(list.min()! + 1)
	}
	
	return minimumFuel
}

//print(GasStation(["4", "1:1", "2:2", "1:2" , "0:1"]))
//print(GasStation(["4", "0:1", "2:2", "1:2" , "3:1"]))
print(GasStation(["4", "3:1", "2:2", "2:1" , "0:1"]))
