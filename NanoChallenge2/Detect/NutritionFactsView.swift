//
//  NutritionFactsView.swift
//  NanoChallenge2
//
//  Created by Eric Prasetya Sentosa on 23/05/23.
//

import SwiftUI

struct NutritionFactsView: View {
    @EnvironmentObject var foodVM: FoodViewModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(AppColor.yellow)
                .overlay(
                    
                    VStack(alignment: .leading, spacing: 0) {
                        CenterView {
                            Text("Nutrition Facts")
                                .bold()
                                .font(.callout)
                        }
                        
                        VStack(spacing: 7) {
                            HStack {
                                Text("Protein")
                                Image("Protein")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 16)
                                Spacer()
                                Text("\(printDouble(value: foodVM.result!.protein)) g")
                            }
                            HStack {
                                Text("Carbs")
                                Image("Carbs")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 16)
                                Spacer()
                                Text("\(printDouble(value: foodVM.result!.carbs)) g")
                            }
                            
                            HStack {
                                Text("Fat")
                                Image("Fat")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 16)
                                Spacer()
                                Text("\(printDouble(value:foodVM.result!.fat)) g")
                            }
                        }
                        .padding(.bottom, 14)
                        
                        HStack {
                            Text("Calories")
                            Image("Calories")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 16)
                            Spacer()
                            Text("\(printDouble(value: foodVM.result!.calories)) kcal")
                        }
                    }
                    .padding()
                    .font(.callout)
                )
                .frame(width: 305, height: 146)
            
        }
    }
    
    func printDouble(value: Double) -> String {
        return String(format: "%.2f", value)
    }
}

struct NutritionFactsView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionFactsView()
            .environmentObject(FoodViewModel())
    }
}
