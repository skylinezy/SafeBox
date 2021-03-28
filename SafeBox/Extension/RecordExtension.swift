//
//  RecordExtension.swift
//  SafeBox
//
//  Created by Ryan Zi on 3/10/21.
//

import Foundation
import SwiftUI
import CoreData

extension Record {
    convenience init(context: NSManagedObjectContext, type: RecordTypes) {
        self.init(context: context)
        
        self.id = UUID()
        self.createdOn = Date()
        self.modifiedOn = Date()
        
        self.type = type.rawValue
    }
    var recordType: RecordTypes {
        get {
            return RecordTypes(rawValue: self.type)!
        }
        set {
            self.type = newValue.rawValue
        }
    }
    
    var dateFormatter: DateFormatter {
        return DateFormatter()
    }
    
    var createdOnStr: String {
        self.dateFormatter.dateStyle = .short
        self.dateFormatter.timeStyle = .short
        
        return self.dateFormatter.string(from: self.createdOn!);
    }
    
    var modifiedOnStr: String {
        self.dateFormatter.dateStyle = .short
        self.dateFormatter.timeStyle = .short
        
        return self.dateFormatter.string(from: self.modifiedOn!);
    }
    
    func toDictionary() -> [String: Any] {
        var retVal : [String: Any]
        do {
            try retVal = JSONSerialization.jsonObject(with: self.data!, options: []) as! [String : Any]
        } catch {
            fatalError("Cannot convert input data to dictionary")
        }
        return retVal
    }
    
    func setStringField(field name: String, value: String) {
        
    }
    
    func setBoolField(field name: String, value: Bool) {
        
    }
    
    func setEnumField(field name: String, rawValue: Int32) {
        
    }
    
    func setDateField(field name: String, value: Date) {
        
    }
    
    func setData(data: [String: Any]) {
        do {
           try self.data = JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        } catch {
            fatalError("Cannot serialize input data")
        }
    }
}
