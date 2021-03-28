//
//  EditButton.swift
//  SafeBox
//
//  Created by Ryan Zi on 3/11/21.
//

import SwiftUI

struct EditButton: View {
    @Binding var isEditable: Bool
    @State var dragState = CGSize.zero
    
    @GestureState var isDragging = false
    
    var lockAction: () -> Void
    
    let hapticImpact = UIImpactFeedbackGenerator(style: .medium)
    
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
                    hapticImpact.impactOccurred()
                    self.isEditable = true
                }
                self.dragState = CGSize.zero
            }
        
        let tapGesture = TapGesture(count: 1)
            .onEnded {_ in
                self.isEditable = false
                lockAction()
                hapticImpact.impactOccurred()
            }
        
        let pressAndDragGesture = longPressGestureDelay.simultaneously(with: tapGesture)
        
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
                .zIndex(1)
                
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
    }
}

struct EditButton_PreviewHelper: View {
    @State private var editable: Bool = false
    
    var body: some View {
        EditButton(isEditable: $editable, lockAction: {})
    }
}

struct EditButton_Previews: PreviewProvider {
    static var previews: some View {
        EditButton_PreviewHelper()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
