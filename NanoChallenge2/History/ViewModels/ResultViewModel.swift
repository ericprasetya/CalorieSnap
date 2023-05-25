//
//  ResultViewModel.swift
//  NanoChallenge2
//
//  Created by Eric Prasetya Sentosa on 24/05/23.
//

import Foundation

class ResultViewModel: ObservableObject {
//    @Published var results: [Result] = []
    @Published var resultsModels: [ResultModel] = []
    
    func getAllResults() {
        resultsModels = DataManager.shared.getAllResults().map(ResultModel.init)
        print(DataManager.shared.getAllResults())
//        tasks.reverse()
//        recommendedTasks = []
//        for task in tasks {
//            recommendedTasks.append(RecommendationTaskModel(title: task.title, desc: task.desc, percentage: task.percentage))
//        }
    }
    
    func clearAllResults() {
        DataManager.shared.clearAllResult()
        resultsModels = []
    }
}
