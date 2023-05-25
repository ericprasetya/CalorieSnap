//
//  HistoryView.swift
//  NanoChallenge2
//
//  Created by Eric Prasetya Sentosa on 23/05/23.
//

import SwiftUI

struct HistoryView: View {
    @StateObject var resultVM = ResultViewModel()
    @State var isPresentingConfirm = false
    var body: some View {
        NavigationView {
            ZStack {
                AppColor.whiteBone
                    .edgesIgnoringSafeArea(.top)
                
                VStack {
                    HStack {
                        Text("History")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(AppColor.darkGreen)
                        Spacer()
                        Button {
                            isPresentingConfirm.toggle()
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                                .font(.title3)
                        }
                    }
                    .padding(.top, 20)
                    
                    ScrollView {
                        ForEach(resultVM.resultsModels) { result in
                            HistoryCardView(result: result)
                                .padding(.bottom, 30)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                .padding(.top)
                .padding(.horizontal)
            }
        }
        .confirmationDialog("Are you sure?", isPresented: $isPresentingConfirm) {
            Button("Clear All History?", role: .destructive) {
                resultVM.clearAllResults()
            }
        } message: {
          Text("You cannot undo this action")
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            resultVM.getAllResults()
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
