//
//  EmptyListView.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/15/20.
//

import SwiftUI

struct EmptyListView: View {
    //MARK: - Properties
    @State private var isAnimated: Bool = false
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Image("EmptyListBackground")
            
            VStack(alignment: .center, spacing: 20) {
                Text("Welcome to SafeBox!")
                    .layoutPriority(0.5)
                    .font(.system(.title, design: .rounded))
                Text("Add your first record")
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
            }//: VSTACK
            .padding(.horizontal)
            .opacity(isAnimated ? 1 : 0)
            .offset(y: isAnimated ? 0 : -20)
            .animation(.easeOut(duration: 1.0))
            .onAppear(perform: {
                self.isAnimated.toggle()
            })
        }//: ZSTACK
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        //.background(Color("ColorBase"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
