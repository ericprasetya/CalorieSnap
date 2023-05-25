//
//  HistoryCardView.swift
//  NanoChallenge2
//
//  Created by Eric Prasetya Sentosa on 23/05/23.
//

import SwiftUI

struct HistoryCardView: View {
    var result: ResultModel
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("\(result.dateCreated.formatted(date: .complete, time: .shortened))")
                .font(.body)
                .bold()
            HStack(spacing: 0) {
                Rectangle()
                    .fill(AppColor.darkGreen)
                    .clipShape(RoundedCorner(radius: 8, corners: [.topLeft, .bottomLeft]))
                    .overlay(
                        VStack(alignment: .leading, spacing: 1) {
                            Text("Foods")
                                .bold()
                                .font(.subheadline)
                            
                            Group {
                                Text("\(result.foods)")
//
//                                Text("Bread (100g)")
                            }
                            .font(.system(size: 14))
                            
                            Spacer()
                        }
                            .foregroundColor(AppColor.whiteBone)
                            .padding(10)
                    )
                    .frame(width: 110, height: 120)
                
                Rectangle()
                    .fill(AppColor.yellow)
                    .clipShape(RoundedCorner(radius: 8, corners: [.topRight, .bottomRight]))
                    .overlay(
                        VStack(spacing: 1) {
                            Text("Nutrition Facts")
                                .bold()
                                .font(.subheadline)
                                .padding(.bottom, 2)
                            
                            Group {
                                HStack {
                                    Text("Protein")
                                    Image("Protein")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 14)
                                    Spacer()
                                    Text("\(printDouble(value: result.protein)) g")
                                }
                                HStack {
                                    Text("Carbs")
                                    Image("Carbs")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 14)
                                    Spacer()
                                    Text("\(printDouble(value: result.carbs)) g")
                                }
                                
                                HStack {
                                    Text("Fat")
                                    Image("Fat")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 14)
                                    Spacer()
                                    Text("\(printDouble(value: result.fat)) g")
                                }
                                .padding(.bottom, 6)
                                
                                HStack {
                                    Text("Calories")
                                    Image("Calories")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 14)
                                    Spacer()
                                    Text("\(printDouble(value: result.calories)) kcal")
                                }
                            }
                            .font(.system(size: 14))
                            Spacer()
                        }
                        .padding(10)
                    )
                    .frame(maxWidth: 210, maxHeight: 120)
            }
        }
    }
    func printDouble(value: Double) -> String {
        return String(format: "%.2f", value)
    }
}

struct HistoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCardView(result: ResultModel(result: Result(context: DataManager.shared.viewContext)))
    }
}
