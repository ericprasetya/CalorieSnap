//
//  FoodViewModel.swift
//  NanoChallenge2
//
//  Created by Eric Prasetya Sentosa on 24/05/23.
//

import Foundation

class FoodViewModel: ObservableObject {
    @Published var detectedFoods: [DetectedFood] = []
    @Published var allFoods: [Food] = foods
    @Published var result: Result?
    func getFood(name: String) -> Food? {
        return allFoods.first { $0.name == name }
    }
    
    func fillDetectedFoods(foodNames: [String]) {
        for foodName in foodNames {
            let food = getFood(name: foodName)
            detectedFoods.append(DetectedFood(food: food!, weight: ""))
        }
    }
    
    func calculateResult() {
        var protein: Double = 0
        var carbs: Double = 0
        var fat: Double = 0
        var calories: Double = 0
        var foods: String = ""
        
        for detectedFood in detectedFoods {
            foods = foods + "\(detectedFood.food.name) (\(detectedFood.weight) grams)\n"
            protein = protein + detectedFood.food.protein * detectedFood.getWeight()
            carbs = carbs + detectedFood.food.carbs * detectedFood.getWeight()
            fat = fat + detectedFood.food.fat * detectedFood.getWeight()
            calories = calories + detectedFood.food.calories * detectedFood.getWeight()
        }
        
        let result = Result(context: DataManager.shared.viewContext)
        result.foods = foods
        result.carbs = roundDouble(value: carbs)
        result.calories = roundDouble(value: calories)
        result.protein = roundDouble(value: protein)
        result.fat = roundDouble(value: fat)
        result.dateCreated = Date()
        
        DataManager.shared.save()
        print(result)
        
        self.result = result
    }
    func roundDouble(value: Double) -> Double {
        return Double(round(100 * value) / 100)
    }
    
}
