//
//  ContentView.swift
//  NanoChallenge2
//
//  Created by Eric Prasetya Sentosa on 23/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView() {
            DetectView()
            .tabItem {
                Label("Detect", systemImage: "camera")
            }
            
            HistoryView()
            .tabItem {
                Label("History", systemImage: "list.bullet.rectangle.portrait")
            }
        }
        .tabViewStyle(.automatic)
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
