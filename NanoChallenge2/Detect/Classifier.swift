//
//  Classifier.swift
//  NanoChallenge2
//
//  Created by Eric Prasetya Sentosa on 24/05/23.
//

import CoreML
import Vision
import CoreImage

struct Classifier {
    
    private(set) var results: [VNRecognizedObjectObservation]?
    
    mutating func detect(ciImage: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: FoodDetectorModel(configuration: MLModelConfiguration()).model)
        else {
            return
        }
        
        let request = VNCoreMLRequest(model: model)
//        request.imageCropAndScaleOption = .scaleFill
        
        let handler = VNImageRequestHandler(ciImage: ciImage, orientation: .up, options: [:])
        try? handler.perform([request])
        
        guard let results = request.results as? [VNRecognizedObjectObservation] else {
            return
        }
        self.results = results
        print(results)
//        if let firstResult = results.first {
//            self.results = firstResult.identifier
//        }
        
    }
    
}

