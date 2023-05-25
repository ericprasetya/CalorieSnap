//
//  DetectResultView.swift
//  NanoChallenge2
//
//  Created by Eric Prasetya Sentosa on 23/05/23.
//

import SwiftUI
import Vision
struct ObjectDetectionView: View {
    let image: UIImage
    let observations: [VNRecognizedObjectObservation]?
    
    @State private var setRotate: Angle = .degrees(0)
    @State private var setPosition: CGPoint = .zero
    
    var body: some View {
        if observations == nil {
            CenterView {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 240, height: 240)
                    .cornerRadius(20)
                
            }
        } else {
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 240, height: 240)
                        .cornerRadius(20)
//                        .rotationEffect(setRotate)
//                        .position(setPosition)
                    
                    if let observations = observations {
                        ForEach(observations, id: \.self) { observation in
                            let convertedRect = convertRect(observation.boundingBox, imageSize: image.size, viewSize: CGSize(width: 240/image.size.height*image.size.width, height: 240))
                            BoundingBoxView(rect: convertedRect)
//                                .position(x: convertedRect.midX, y: convertedRect.midY)
                            ObjectLabel(label: observation.labels.first?.identifier ?? "Unknown", rect: convertedRect)
                        }
                    }
                }
                .onAppear {
                    updateLayerGeometry(bounds: geometry.frame(in: .local), bufferSize: image.size)
                }
            }
        }
    }
    
    func updateLayerGeometry(bounds: CGRect, bufferSize: CGSize) {
        let scaleFactor = min(bounds.size.width / bufferSize.width, bounds.size.height / bufferSize.height)
        let scaledImageSize = CGSize(width: bufferSize.width * scaleFactor, height: bufferSize.height * scaleFactor)
        let xPosition = (bounds.size.width - scaledImageSize.width) / 2
        let yPosition = (bounds.size.height - scaledImageSize.height) / 2
        
        setRotate = .degrees(90)
        setPosition = CGPoint(x: xPosition + (scaledImageSize.width / 2), y: yPosition + (scaledImageSize.height / 2))
    }
    
    private func convertRect(_ rect: CGRect, imageSize: CGSize, viewSize: CGSize) -> CGRect {
        let imageWidth = imageSize.width
        let imageHeight = imageSize.height
        let viewWidth = viewSize.width
        let viewHeight = viewSize.height
        
        let x = rect.origin.x * imageWidth
        let y = (rect.origin.y) * imageHeight
        let width = rect.size.width * imageWidth
        let height = rect.size.height * imageHeight
        
        let convertedRect = CGRect(x: x, y: y, width: width, height: height)
        
        let scaleX = viewWidth / imageWidth
        let scaleY = viewHeight / imageHeight
        
        let transformedRect = CGRect(x: convertedRect.origin.x * scaleX, y: convertedRect.origin.y * scaleY, width: convertedRect.size.width * scaleX, height: convertedRect.size.height * scaleY)
        
        return transformedRect
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
            .stroke(Color.red, lineWidth: 2)
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
