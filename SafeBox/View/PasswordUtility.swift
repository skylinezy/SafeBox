//
//  PasswordGenerator.swift
//  SafeBox
//
//  Created by Ryan Zi on 8/26/21.
//

import Foundation
import CryptoKit

extension String {
    func md5() -> String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
        
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}

func passwordGenerator(length: Int, hasSymbol: Bool, hasNumber: Bool, hasUppercase: Bool, hasLowercase: Bool) -> String {
    
    var result = ""
    
    if !hasSymbol && !hasNumber && !hasUppercase && !hasLowercase {
        return result
    }
    
    let symbols = "~!@#$%^&*?-_=+"
    let lowercase = "abcdefghijklmnopqrstuvwxyz"
    let uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let number = "0123456789"
    
    var n = length
    var candidates = [String]()
    if hasLowercase {
        result += String(lowercase.randomElement()!)
        candidates.append(lowercase)
        n -= 1
    }
    if hasUppercase {
        result += String(uppercase.randomElement()!)
        candidates.append(uppercase)
        n -= 1
    }
    if hasSymbol {
        result += String(symbols.randomElement()!)
        candidates.append(symbols)
        n -= 1
    }
    if hasNumber {
        result += String(number.randomElement()!)
        candidates.append(number)
        n -= 1
    }
    
    for _ in 0..<n {
        let c = candidates.randomElement()!
        result += String(c.randomElement()!)
    }
    
    
    return String(result.shuffled())
}
