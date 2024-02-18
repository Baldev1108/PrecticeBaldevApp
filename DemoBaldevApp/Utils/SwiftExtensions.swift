//
//  SwiftExtensions.swift
//  FantasyJi
//
//  Created by Gangajaliya Sandeep on 05/03/19.
//  Copyright © 2019 Gangajaliya Sandeep. All rights reserved.
//

import UIKit
import UniformTypeIdentifiers

// MARK:- Date

extension Date {
    func daySuffix() -> String {
        let calendar = Calendar.current
        let dayOfMonth = calendar.component(.day, from: self)
        switch dayOfMonth {
            case 1, 21, 31: return "st"
            case 2, 22: return "nd"
            case 3, 23: return "rd"
            default: return "th"
        }
    }

}
extension UILabel {

    func startBlink() {
        UIView.animate(withDuration: 0.8,
              delay:0.0,
              options:[.allowUserInteraction, .curveEaseInOut, .autoreverse, .repeat],
              animations: { self.alpha = 0 },
              completion: nil)
    }

    func stopBlink() {
        layer.removeAllAnimations()
        alpha = 1
    }
}








// MARK:- Data

extension Data {
    func decode<T>(type: T.Type) -> T? where T: Decodable {
        
        do {
            return try JSONDecoder().decode(type, from: self)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func asJson() -> Any? {
        do {
            let obj = try JSONSerialization.jsonObject(with: self, options: .mutableContainers)
            return obj
        } catch let error {
            print("JsonSerialization error : \(error.localizedDescription)")
            return nil
        }
    }
}

// MARK:- Dictionary
extension Dictionary {
    var data: Data? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return data
        } catch let error {
            print("Dictionary to Data casting error : \(error.localizedDescription)")
            return nil
        }
    }
    
    func decode<T>(type: T.Type) -> T? where T: Decodable {
        
        do {
            if let data = self.data {
                return try JSONDecoder().decode(type, from: data)
            }
            return nil
        } catch let error {
            print(error)
            return nil
        }
    }

}


// MARK:- Double

extension Double {
    
    func removeTrailingZero() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }

}


// MARK:- Bundle

extension Bundle {
    var releaseVersionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    var buildVersionNumber: String {
        return infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
}


// MARK:- TypeCasting

protocol TypeCasting {
    var asString: String { get }
    var asInt: Int { get }
    var asFloat: Float { get }
    var asDouble: Double { get }
    var asDecimalString: String { get }
    //var isZero: Bool { get }
}

extension TypeCasting {
    var asString: String {
        return "\(self)"
    }
    
    var asInt: Int  {
        var value = 0
        
        if self is String {
            value = Int(Float(self as! String) ?? 0)
        } else if self is NSNumber {
            value = (self as! NSNumber).intValue
        }
        return value
    }
    
    var asFloat: Float {
        var value: Float = 0.0
        
        if self is String {
            value = Float(self as! String) ?? 0
        } else if self is NSNumber {
            value = (self as! NSNumber).floatValue
        }
        return value
    }
    
    var asDouble: Double {
        var value: Double = 0.0
        
        if self is String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            
            if let number = formatter.number(from: self as! String) {
                return number.doubleValue
            }
            
            value = Double(self as! String) ?? 0
            
        } else if self is NSNumber {
            value = (self as! NSNumber).doubleValue
        }
        return value
        
        
    }
    
    var asDecimalString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        if self is String {
            
            if let number = formatter.number(from: self as! String) {
                return number.stringValue
            } else {
                return "0"
            }
            
        } else if self is NSNumber {
            let number = (self as! NSNumber)
            return formatter.string(from: number) ?? "0"
        }
        return "0"
    }
}



extension String: TypeCasting { }
extension Int: TypeCasting { }
extension Double: TypeCasting { }
extension Float: TypeCasting { }
extension CGFloat: TypeCasting { }



// MARK:- UIDevice

extension UIDevice {
    enum DeviceType {
        case iPhone35
        case iPhone40
        case iPhone47
        case iPhone55
        case iPhoneX
        case iPhoneMax
        case iPad
        case TV
        case carPlay
        case unspecified
        
        var isPhone: Bool {
            return [ .iPhone35, .iPhone40, .iPhone47, .iPhone55, .iPhoneMax ].contains(self)
        }
        
    }
    
//    var deviceType: DeviceType {
//        switch UIDevice.current.userInterfaceIdiom {
//        case .tv:
//            return .TV
//            
//        case .pad:
//            return .iPad
//            
//        case .phone:
//            let screenSize = UIScreen.main.bounds.size
//            let height = max(screenSize.width, screenSize.height)
//            
//            switch height {
//                
//            case 480:
//                return .iPhone35
//            case 568:
//                return .iPhone40
//            case 667:
//                return .iPhone47
//            case 736:
//                return .iPhone55
//            case 812:
//                return .iPhoneX
//            case 896:
//                return .iPhoneMax
//            default:
//                
//                return .unspecified
//            }
//            
//        case .unspecified:
//            return .unspecified
//            
//        case .carPlay:
//            return .carPlay
//        }
//    }
}

extension NSURL {
    public func mimeType() -> String {
        if #available(iOS 14.0, *) {
            if let pathExt = self.pathExtension,
               let mimeType = UTType(filenameExtension: pathExt)?.preferredMIMEType {
                return mimeType
            }
            else {
                return "application/octet-stream"
            }
        } else {
            // Fallback on earlier versions
            return "application/octet-stream"
        }
    }
}

extension URL {
    public func mimeType() -> String {
        if #available(iOS 14.0, *) {
            if let mimeType = UTType(filenameExtension: self.pathExtension)?.preferredMIMEType {
                return mimeType
            }
            else {
                return "application/octet-stream"
            }
        } else {
            // Fallback on earlier versions
            return "application/octet-stream"
        }
    }
}

extension NSString {
    public func mimeType() -> String {
        if #available(iOS 14.0, *) {
            if let mimeType = UTType(filenameExtension: self.pathExtension)?.preferredMIMEType {
                return mimeType
            }
            else {
                return "application/octet-stream"
            }
        } else {
            // Fallback on earlier versions
            return "application/octet-stream"
        }
    }
}

extension String {
    public func mimeType() -> String {
        return (self as NSString).mimeType()
    }
}
