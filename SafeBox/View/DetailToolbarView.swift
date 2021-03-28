//
//  DetailToolbarView.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/15/20.
//

import SwiftUI

struct DetailToolbarView: View {
    //MARK: - Properties
    // Two-Way binding across views
    @Binding var isEditable: Bool
    @Binding var isDeleting: Bool
    
    @State var dragState = CGSize.zero
    
    @GestureState var isDragging = false
    
    //MARK: - Body
    var body: some View {
        let longPressGestureDelay = DragGesture(minimumDistance: 0)
            .updating($isDragging) { value, gestureState, transaction in
                gestureState = true
                //self.dragState = value.translation
            }
            .onChanged { gesture in
                self.dragState = gesture.translation
            }
            .onEnded { value in
                if (value.translation.width > 140) {
                    self.isEditable = true
                }
                self.dragState = CGSize.zero
            }
        
        let tapGesture = TapGesture(count: 1)
            .onEnded {_ in self.isEditable = false}
        
        let pressAndDragGesture = longPressGestureDelay.simultaneously(with: tapGesture)
        
        HStack{
            
            ZStack(alignment: .leading){
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(height: 60)
                    .cornerRadius(30)
                    .opacity((isDragging && !isEditable) ? 1.0 : 0.0)
                    .animation(.easeIn(duration: 0.1))
                
                HStack(){
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 50, height: 50)
                            .modifier(TextDropShadow())
                            .opacity((isDragging && !isEditable) ? 1.0 : 0.0)
                        
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors:SBColors().BlueButton), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 46, height: 46)
                            .modifier(TextDropShadow())
                            .opacity((isDragging && !isEditable) ? 1.0 : 0.0)
                        
                        Image(systemName: isEditable ? "lock.open" : "lock")
                            .font(Font.system(size: 28, weight: .regular))
                            .foregroundColor(Color.white)
                            .frame(width: 35, height: 35)
                            .modifier(TextDropShadow())
                    }
                    .offset(x: (self.isDragging && !self.isEditable) ? self.dragState.width : 0)
                    .gesture(pressAndDragGesture)
                    
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .fill(Color("BtnBlueLight"))
                            .frame(width: 50, height: 50)
                            .modifier(TextDropShadow())
                        
                        Image(systemName: "lock.open")
                            .font(Font.system(size: 28, weight: .regular))
                            .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.9))
                            .frame(width: 35, height: 35)
                            .modifier(TextDropShadow())
                    }
                    .opacity((isDragging && !isEditable) ? 1.0 : 0.0)
                    .animation(.easeIn(duration: 0.1))
                }
                .padding(.horizontal, 5)
 
            }
            .frame(width: 200)
            
            Spacer()
            
            Button(action: {
                isDeleting = true
            }) {
                Image(systemName: "trash")
                    .font(Font.system(size: 28, weight: .regular))
                    .foregroundColor(Color("BtnRed"))
                    .frame(width: 35, height: 35)
                    .modifier(TextDropShadow())
            }
        }
        .padding(.vertical, 10)
    }
}

struct DetailToolbarView_PreviewHelper: View {
    @State private var editable: Bool = false
    @State private var deleting: Bool = false
    
    var body: some View {
         DetailToolbarView(isEditable: $editable, isDeleting: $deleting)
    }
}

struct DetailToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        DetailToolbarView_PreviewHelper()
            .preferredColorScheme(.light)
            .previewLayout(.fixed(width: 375, height: 80))
            .padding()
    }
}
