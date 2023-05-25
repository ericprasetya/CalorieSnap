//
//  ImageClassifier.swift
//  NanoChallenge2
//
//  Created by Eric Prasetya Sentosa on 24/05/23.
//

import SwiftUI
import Vision
class ImageClassifier: ObservableObject {
    
    @Published private var classifier = Classifier()
    
    //    var imageClass: String? {
    //        classifier.results.
    //    }
    
    var results: [VNRecognizedObjectObservation]? {
        classifier.results
    }
    
    func getFoods() -> [String] {
        guard let observations = classifier.results else {
            // Handle case when observations are nil
            return []
        }
        
        var objectNames: [String] = []

        for observation in observations {
//            guard let labels = observation.labels as? [VNClassificationObservation] else {
//                // Handle case when labels cannot be cast to [VNClassificationObservation]
//                continue
//            }
            let labels = observation.labels
            let objectName = labels.first?.identifier ?? "Unknown"
            objectNames.append(objectName)
            
//            for label in labels {
//                let objectName = label.identifier
//                objectNames.append(objectName)
//            }
        }
        return objectNames
    }
    
    // MARK: Intent(s)
    func detect(uiImage: UIImage) {
        guard let ciImage = CIImage (image: uiImage) else { return }
        classifier.detect(ciImage: ciImage)
        
    }
        
}
