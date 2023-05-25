//
//  FoodWeightFormView.swift
//  NanoChallenge2
//
//  Created by Eric Prasetya Sentosa on 24/05/23.
//

import SwiftUI
import Camera_SwiftUI
struct FoodWeightFormView: View {
    @State var weight: String = ""
    @EnvironmentObject var foodVM: FoodViewModel
    var body: some View {
        ForEach($foodVM.detectedFoods) { $food in
            Group {
                Text(food.food.name)
                    .foregroundColor(AppColor.whiteBone)
                    .font(.headline)
                    .padding(.bottom, 10)

                LabeledContent() {
                    TextField("in grams", text: $food.weight)
                    .keyboardType(.decimalPad)
                } label: {
                    Text("Weight")
                        .padding(.trailing, 10)
                }
                .font(.subheadline)
                .foregroundColor(.black)
                .padding()
                .frame(height: 44)
                .background(AppColor.whiteBone)
                .cornerRadius(10)
                .padding(.bottom, 14)
            }
        }
    }
}

struct FoodWeightFormView_Previews: PreviewProvider {
    static var previews: some View {
        FoodWeightFormView()
            .environmentObject(FoodViewModel())
    }
}
