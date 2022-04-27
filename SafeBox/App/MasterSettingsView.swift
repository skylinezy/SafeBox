//
//  MasterSettingsView.swift
//  SafeBox
//
//  Created by Ryan Zi on 3/28/21.
//

import SwiftUI

class SettingObject<KeyType>: ObservableObject {
    init(key: String, defaultValue: KeyType) {
        self.key = key
        self.value = UserDefaults.standard.object(forKey: self.key) as? KeyType ?? defaultValue
    }
    
    var key: String
    @Published var value: KeyType {
        didSet {
            UserDefaults.standard.set(value, forKey: self.key)
        }
    }
}

struct TextSettingListItem: View {
    var iconName: String = "gearshape"
    var title: String = "Default Text Setting"
    var desc: String = ""
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .firstTextBaseline){
                Image(systemName: iconName)
                    .font(.title3)
                Text(title)
                    .font(.title3)
                Spacer()
            }
            .padding(.vertical, 8)
            Text(desc)
                .font(.footnote).italic()
                .padding(.leading, 10)
                .padding(.vertical, 10)
        }
        .padding(.vertical, 5)
    }
}

struct ToggleSettingListItem: View {
    var title: String = "Default Setting"
    var desc: String = ""
    @Binding var value: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            Toggle(isOn: $value){
                Text(title)
                    .font(.title3)
            }
            Text(desc)
                .font(.footnote).italic()
                .padding(.leading, 10)
        }
        .padding(.vertical, 5)
    }
}

struct MasterSettingsView: View {
    
    @State var placeholder: String = ""  // Placeholder for a empty label. Never change this var
    
    @ObservedObject var masterPassword = SettingObject<String>(key: "KMASTER_PASSWORD", defaultValue: "")
    @ObservedObject var defaultUsername = SettingObject<String>(key: "KDEFAULT_USERNAME", defaultValue: "")
    @ObservedObject var defaultPassword = SettingObject<String>(key: "KDEFAULT_PASSWORD", defaultValue: "")
    @ObservedObject var defaultEmail  = SettingObject<String>(key: "KDEFAULT_EMAIL", defaultValue: "")
    @ObservedObject var defaultAddress = SettingObject<String>(key: "KDEFAULT_ADDRESS", defaultValue: "")
    
    @ObservedObject var autoLock = SettingObject<Bool>(key: "KAUTO_LOCK", defaultValue: true)
    @ObservedObject var faceID = SettingObject<Bool>(key: "KBIOMETRICS_ID", defaultValue: false)
    
    var body: some View {
        NavigationView {
            List(){
                Section() {
                    
                    NavigationLink(destination:MasterPasswordEditView(value: $masterPassword.value)
                    ) {
                        TextSettingListItem(iconName: "key", title: "Master Password", desc: "The login password of the App", value: $masterPassword.value)
                    }
                    
                    NavigationLink(destination:TextEditView(title: "New Default Password", value: $defaultPassword.value)
                    ) {
                        TextSettingListItem(iconName: "lock.shield", title: "Default Passwords", desc: "The default passwords for a credential record. It will be populated automatically when you creating new credential record", value: $defaultPassword.value)
                    }
                    
                    
                    NavigationLink(destination:TextEditView(title: "New Default Username", value: $defaultUsername.value)
                    ) {
                        TextSettingListItem(iconName: "person.circle", title: "Default Username", desc: "The default username for a credential record. It will be populated automatically when you creating new credential record", value: $defaultUsername.value)
                    }
                    
                    NavigationLink(destination:TextEditView(title: "New Default Email", value: $defaultEmail.value)
                    ) {
                        TextSettingListItem(iconName: "envelope", title: "Default Email", desc: "The default email address for a credential record. It will be populated automatically when you creating new credential record", value: $defaultEmail.value)
                    }
                    
                    NavigationLink(destination:TextEditView(multiLine: true, title: "New Default Address", value: $defaultAddress.value)
                    ) {
                        TextSettingListItem(iconName: "mappin.and.ellipse", title: "Default Address", desc: "The default address for a bank card record", value: $defaultAddress.value)
                    }
                }
                
                
                Section() {
                    
                    ToggleSettingListItem(title: "Auto Lock", desc: "Lock the App automatically when the App switched to background", value: $autoLock.value)
                    
                    ToggleSettingListItem(title: "Face ID", desc: "", value: $faceID.value)
                }
            }
            .navigationBarTitle("Settings", displayMode: .large)
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct TextSettingListItem_PreviewHelper: View {
    @State var value: String = "aaa"
    var body: some View {
        TextSettingListItem(desc: "adf adfhh adlf hawhh la flah aewhjha lfaldfh aj hlfjaew", value: $value)
    }
}

struct MasterSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MasterSettingsView()
    }
}

struct TextSettingListItem_Previews: PreviewProvider {
    static var previews: some View {
        TextSettingListItem_PreviewHelper()
    }
}


