//
//  EmptyListView.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/15/20.
//

import SwiftUI

struct EmptyListView: View {
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .center) {
            Image("EmptyListBackground")
                .opacity(0.4)
            
            VStack(alignment: .center, spacing: 20) {
                Text("Welcome to SafeBox!")
                    .font(.title)
                Text("Add your first record")
                    .font(.title2)
            }//: VSTACK
            .padding(.horizontal)
        }//: ZSTACK
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
