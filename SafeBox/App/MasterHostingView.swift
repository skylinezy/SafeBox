//
//  MasterHostingView.swift
//  SafeBox
//
//  Created by Ryan Zi on 9/3/21.
//

import SwiftUI

enum ViewName: Int8 {
    case SettingView = 0
    case MainListView = 1
    case SearchView = 2
}

class NewItemViewState: ObservableObject {
    @Published var isShowing: Bool = false
    @Published var type: RecordTypes = .Unknown {
        didSet { isShowing = type != .Unknown }
    }
}

struct MasterHostingView: View {
    let contentBottomSafeArea = CGFloat(90.0)
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var currentView : ViewName = .MainListView
    @State private var typeChoosePresenting: Bool = false
    @ObservedObject private var newItemType = NewItemViewState()
    
    @GestureState private var startPos: CGPoint? = nil
    @State var currPos : CGPoint = CGPoint(x:UIScreen.main.bounds.maxX, y:120)
    @State private var toolbarInDrag: Bool = false
    
    @ViewBuilder
    private func newItemViewContent() -> some View {
        switch newItemType.type {
        case .Credential:
            CredentialDetailView(isEditable: true, enableDeletion: false)
                .padding(.horizontal, 8)
        case .BankCard:
            BankCardDetailView(isEditable: true, enableDeletion: false)
                .padding(.horizontal, 8)
        case .Note:
            NoteDetailView(isEditable: true, enableDeletion: false)
                .padding(.horizontal, 8)
        default:
            Text("DefaultView")
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            let SnapArea: CGRect = CGRect(x: geometry.size.width - 80, y: 30, width: 82, height: geometry.size.height - 100)
            
            let hapticImpact = UIImpactFeedbackGenerator(style: .medium)
            let longPressGesture = LongPressGesture(minimumDuration: 0.3)
                .onEnded { finished in
                    toolbarInDrag = true
                    hapticImpact.impactOccurred()
                }
            
            let dragGesture = DragGesture(minimumDistance: 0, coordinateSpace: CoordinateSpace.named("MasterHostingView"))
                .updating($startPos) { value, gestureStart, transaction in
                    gestureStart = gestureStart ?? currPos
                }
                .onChanged { gesture in
                    var newLocation = startPos ?? currPos
                    newLocation.x += gesture.translation.width
                    newLocation.y += gesture.translation.height
                    self.currPos = newLocation
                    
                    if !SnapArea.contains(newLocation) {
                        if newLocation.x <= SnapArea.minX || newLocation.x >= SnapArea.maxX{
                            self.currPos.x = newLocation.x <= SnapArea.minX ? SnapArea.minX : SnapArea.maxX
                        }
                        if newLocation.y <= SnapArea.minY || newLocation.y >= SnapArea.maxY {
                            self.currPos.y = newLocation.y <= SnapArea.minY ? SnapArea.minY : SnapArea.maxY
                        }
                    }

                }
                .onEnded { value in
                    self.currPos.x = SnapArea.maxX
                    self.toolbarInDrag = false
                }
            
            let longDragGesture = longPressGesture.sequenced(before: dragGesture)
            
            ZStack(alignment: .bottom) {
                switch currentView {
                case .SettingView:
                    MasterSettingsView()
                        .environment(\.managedObjectContext, self.viewContext)
                case .MainListView:
                    NavigationView {
                        RecordListView()
                            .environment(\.managedObjectContext, self.viewContext)
                    }
                    .navigationBarTitle("", displayMode: .large)
                case .SearchView:
                    Text("SearchView")
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
                
                // Bottom Bar
                HStack() {
                    Button(action:{
                        currentView = .SettingView
                    }) {
                        Image(systemName: currentView == .SettingView ? "gearshape.fill" : "gearshape")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 32.0, height: 32.0)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                    }
                    
                    Spacer()
                    Button(action: {
                        currentView = .MainListView
                    }) {
                        Image(systemName: currentView == .MainListView ? "rectangle.grid.1x2.fill" : "rectangle.grid.1x2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 32.0, height: 32.0)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                    }
                    
                    Spacer()
                    Button(action: {
                        currentView = .SearchView
                    }) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 32.0, height: 32.0)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                    }
                }// :HSTACK
                .frame(width: geometry.size.width/10*9, height: geometry.size.height/10)
                .padding(.bottom, 40)
                .background(Color("PrimaryBlue"))
                .cornerRadius(30)
                .modifier(ViewDropShadow())
                .offset(y: 20)
                
                // Floating Add button
                HStack(alignment: .center, spacing: 10) {
                    Button(action: {
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 28.0, height: 28.0)
                            .rotationEffect(.degrees(self.typeChoosePresenting ? 45 : 0))
                            .padding(.horizontal, 18)
                            .padding(.vertical, 2)
                    }
                    .simultaneousGesture(longDragGesture)
                    .simultaneousGesture(TapGesture().onEnded{
                        self.typeChoosePresenting.toggle()
                    })
                    
                    Button(action: {
                        self.newItemType.type = .Credential
                        self.typeChoosePresenting = false
                    }) {
                        Image(systemName: "globe")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 28.0, height: 28.0)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                    }
                    Button(action: {
                        self.newItemType.type = .BankCard
                        self.typeChoosePresenting = false
                    }) {
                        Image(systemName: "creditcard")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 28.0, height: 28.0)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                    }
                    Button(action: {
                        self.newItemType.type = .Note
                        self.typeChoosePresenting = false
                    }) {
                        Image(systemName: "note.text")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 28.0, height: 28.0)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                    }
                    Spacer()
                }
                .frame(width: 300, height: 64)
                .background(Color("PrimaryBlue"))
                .cornerRadius(32)
                .modifier(ViewDropShadow())
                .scaleEffect(self.toolbarInDrag ? 1.2 : 1.0)
                .animation(.easeIn(duration: 0.1), value: self.toolbarInDrag)
                //TODO: set x offset based buttons
                .offset(x: self.typeChoosePresenting ? -60 : 90, y: 0)
                .animation(.spring(), value: self.typeChoosePresenting)
                .position(currPos)
            }
            .coordinateSpace(name: "MasterHostingView")
            .edgesIgnoringSafeArea(.bottom)
            .sheet(
                isPresented: $newItemType.isShowing,
                content: newItemViewContent
            )
        }
    }
}

struct MasterHostingView_Previews: PreviewProvider {
    static var previews: some View {
        MasterHostingView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
    }
}
