//
//  ResultModel.swift
//  NanoChallenge2
//
//  Created by Eric Prasetya Sentosa on 24/05/23.
//

import Foundation
import CoreData
struct ResultModel: Identifiable {
    var result: Result
    
    var id: NSManagedObjectID {
        return result.objectID
    }
    
    var foods: String {
        return result.foods ?? ""
    }
    
    var protein: Double {
        return result.protein
    }
    
    var carbs: Double {
        return result.carbs
    }
    
    var fat: Double {
        return result.fat
    }
    
    var calories: Double {
        return result.calories
    }
    
    var dateCreated: Date {
        return result.dateCreated ?? Date()
    }
    
//    init(result: Result) {
//        self.result = result
//        result.dateCreated = Date()
//    }
}
