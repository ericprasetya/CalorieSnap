//
//  CenterView.swift
//  NanoChallenge2
//
//  Created by Eric Prasetya Sentosa on 23/05/23.
//

import SwiftUI

struct CenterView<Content: View> : View {
    @ViewBuilder var content: Content
    
    var body: some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}

struct CenterView_Previews: PreviewProvider {
    static var previews: some View {
        CenterView{
            Text("test")
        }
    }
}
