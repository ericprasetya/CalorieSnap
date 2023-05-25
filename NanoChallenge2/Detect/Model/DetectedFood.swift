//
//  DetectedFood.swift
//  NanoChallenge2
//
//  Created by Eric Prasetya Sentosa on 24/05/23.
//

import Foundation

struct DetectedFood: Identifiable {
    var id = UUID()
    var food: Food
    var weight: String
    
    func getWeight() -> Double {
        let weightReplaced = weight.replacingOccurrences(of: ",", with: ".")
        if let weightDouble = Double(weightReplaced) {
            return weightDouble
        } else {
            return 0
        }
    }
}
