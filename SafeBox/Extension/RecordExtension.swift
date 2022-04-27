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
    override public func awakeFromInsert() {
        let now = NSDate.init()
        setPrimitiveValue(now, forKey: "createdOn")
    }
    
    convenience init(context: NSManagedObjectContext, type: RecordTypes) {
        self.init(context: context)
        
        self.id = UUID()
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
    
    var createdOnStr: String {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        
        return df.string(from: createdDate!);
    }
    
    var modifiedOnStr: String {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        
        return df.string(from: modifiedDate!);
    }
    
    var lastAccessStr: String {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        
        if lastAccess == nil {
            return "Never"
        }
        return df.string(from: lastAccess!);
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
            self.modifiedDate = Date.init()
        } catch {
            fatalError("Cannot serialize input data")
        }
    }
}
