//
//  DetectView.swift
//  NanoChallenge2
//
//  Created by Eric Prasetya Sentosa on 23/05/23.
//

import SwiftUI



struct DetectView: View {
    @State var showCamera = false
    var body: some View {
        NavigationStack {
            ZStack {
                AppColor.whiteBone
                    .edgesIgnoringSafeArea(.top)
                VStack {
                    Spacer()
                    Image("FoodBackground")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.7)
                }
                VStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Text("CalorieSnap")
                            .font(.largeTitle)
                            .bold()
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36)
                        Spacer()
                    }
                    Text("Discover the Science Behind Your Food.")
                    Spacer()
                }
                .padding(.top, 20)
                .foregroundColor(AppColor.darkGreen)
                .padding()
                
                
                NavigationLink {
                    CameraView()
                } label: {
                    ZStack {
                        Circle()
                            .fill(AppColor.darkGreen)
                            .frame(width: 202)
                        
                        VStack {
                            Image("FoodCamera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 83)
                            Text("Snap Your Food\nHere")
                                .foregroundColor(AppColor.yellow)
                                .font(.title3)
                                .bold()
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
//        .fullScreenCover(isPresented: $showCamera) {
//            CameraView()
//        }
    }
}

struct DetectView_Previews: PreviewProvider {
    static var previews: some View {
        DetectView()
    }
}
