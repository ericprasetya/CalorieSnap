//
//  DetectResultView.swift
//  NanoChallenge2
//
//  Created by Jessica Rachel Santoso on 23/05/23.
//

import SwiftUI
import Vision
struct ObjectDetectionView: View {
    let image: UIImage
    let observations: [VNRecognizedObjectObservation]?
    var body: some View {
        if observations == nil {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 240, height: 240)
                .cornerRadius(20)
        } else {
            GeometryReader { geometry in
                ZStack(alignment: .topLeading) { // Align the bounding boxes and labels to top leading corner
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                    
                    if let observations = observations {
                        ForEach(observations, id: \.self) { observation in
                            let convertedRect = convertRect(observation.boundingBox, imageSize: image.size, viewSize: geometry.size) // Convert the bounding box rect coordinates
                            BoundingBoxView(rect: convertedRect)
                            ObjectLabel(label: observation.labels.first?.identifier ?? "Unknown", rect: convertedRect)
                        }
                    }
                }
                .cornerRadius(20)
            }
            .frame(width: 240, height: 240)
        }
        
    }
    
    private func convertRect(_ rect: CGRect, imageSize: CGSize, viewSize: CGSize) -> CGRect {
        let imageWidth = imageSize.width
        let imageHeight = imageSize.height
        let viewWidth = viewSize.width
        let viewHeight = viewSize.height
        
        let scaleX = viewWidth / imageWidth
        let scaleY = viewHeight / imageHeight
        
        // Convert the bounding box rect coordinates
        let transformedOrigin = CGPoint(x: rect.origin.x * scaleX, y: rect.origin.y * scaleY)
        let transformedSize = CGSize(width: rect.size.width * scaleX, height: rect.size.height * scaleY)
        print(transformedSize)
        return CGRect(origin: transformedOrigin, size: transformedSize)
    }
}


struct ObjectBoundingBox: View {
    let rect: CGRect
    
    var body: some View {
        Rectangle()
            .stroke(Color.red, lineWidth: 2)
            .frame(width: rect.size.width, height: rect.size.height)
            .position(x: rect.midX, y: rect.midY)
    }
}

struct ObjectLabel: View {
    let label: String
    let rect: CGRect
    
    var body: some View {
        Text(label)
            .font(.caption)
            .foregroundColor(.white)
            .background(Color.red)
            .position(x: rect.midX, y: rect.midY - 20)
            .padding(.horizontal, 6)
            .padding(.vertical, 3)
    }
}

struct BoundingBoxView: View {
    let rect: CGRect
    
    var body: some View {
        Rectangle()
            .stroke(Color.red, lineWidth: 10)
            .frame(width: rect.width, height: rect.height)
            .position(x: rect.midX, y: rect.midY)
    }
}


struct DetectResultView: View {
    @State var nextButton = "Get Result"
    @State var showNutritionFacts = false
    @State var title = "Input Food Weight Estimations"
    @State var done = false
    @EnvironmentObject var model: CameraModel
    @ObservedObject var classifier: ImageClassifier
    @StateObject var foodVM = FoodViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColor.whiteBone
                    .edgesIgnoringSafeArea(.top)
                
                VStack {
//                    ObjectDetectionView(image: model.photo.image!, observations: classifier.results)
                    Image(uiImage: model.photo.image!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 240, height: 240)
                        .cornerRadius(20)
                    Spacer()
                }
                .padding(.top, 25)
                
                VStack {
                    Spacer()
                    
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(AppColor.darkGreen)
                            .clipShape(RoundedCorner(radius: 40, corners: [.topLeft, .topRight]))
                        if classifier.results?.count != 0 {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(title)
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(AppColor.yellow)
                                    .padding(.bottom, 14)
                                if showNutritionFacts == false {
                                    FoodWeightFormView()
                                        .environmentObject(foodVM)
                                } else {
                                    NutritionFactsView()
                                        .environmentObject(foodVM)
                                        .padding(.top, 45)
                                }
                                
                                Spacer()
                                HStack {
                                    Spacer()
                                    Button {
                                        if showNutritionFacts == true {
                                            done = true
                                        } else {
                                            withAnimation {
                                                title = "Food Calories Estimations"
                                                nextButton = "Done"
                                                showNutritionFacts = true
                                                foodVM.calculateResult()
                                            }
                                        }
                                    } label: {
                                        Text(nextButton)
                                            .foregroundColor(AppColor.darkGreen)
                                            .font(.headline)
                                            .padding(4)
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .tint(AppColor.whiteBone)
                                }
                                .padding(.bottom, 20)
                            }
                            .padding(.horizontal, 40)
                            .padding(.top, 30)
                        } else {
                            CenterView{
                                Text("CRAP! It's not a food")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(AppColor.yellow)
                            }
                        }
                    }
                    .frame(height: 370)
                }
            }
            .navigationTitle("Result")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $done) {
                DetectView()
            }
        }
        .onAppear {
            print(classifier.results)
            foods = classifier.getFoods()
            foodVM.fillDetectedFoods(foodNames: foods)
            print(foods)
        }
    }
    
    @State var foods: [String] = []
    
    
}



struct DetectResultView_Previews: PreviewProvider {
    static var previews: some View {
        DetectResultView(classifier: ImageClassifier())
            .environmentObject(CameraModel())
    }
}
