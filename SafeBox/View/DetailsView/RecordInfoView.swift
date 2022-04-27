//
//  RecordInfoView.swift
//  SafeBox
//
//  Created by Ryan Zi on 9/1/21.
//

import SwiftUI
import CoreData

struct RecordInfoView: View {
    var model: Record?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            HStack(){
                Image(systemName: "info.circle.fill")
                Text("Created")
                Spacer()
                Text(model?.createdOnStr ?? "Never")
            }
            
            HStack(){
                Image(systemName: "info.circle.fill")
                Text("Last Modified")
                Spacer()
                Text(model?.modifiedOnStr ?? "Never")
            }
            
            HStack(){
                Image(systemName: "info.circle.fill")
                Text("Last Visited")
                Spacer()
                Text(model?.lastAccessStr ?? "Never")
            }
        }// :VSTACK
        .padding(.horizontal, 15)
        .font(.footnote)
        .foregroundColor(.white)
        .frame(width: UIScreen.main.bounds.width - 40, height: 150)
        .background(Color("PrimaryGray"))
        .cornerRadius(18.0)
    }// :BODY
}

struct RecordInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RecordInfoView(model: nil)
    }
}
