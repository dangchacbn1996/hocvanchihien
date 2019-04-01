//
//  UIColorExtension.swift
//  DerivativeIOS
//
//  Created by Dao Hai on 10/3/18.
//  Copyright © 2018 Ngo Dang Chac. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hexString: String) {
        
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (0, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    var toHex: String? {
        return toHex()
    }
    
    // MARK: - From UIColor to String
    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
    struct WorldIndex {
        static var red: UIColor  { return UIColor(red: 218/255, green: 85/255, blue: 100/255, alpha: 1) }
        static var green: UIColor { return UIColor(red: 80/255, green: 202/255, blue: 120/255, alpha: 1) }
        static var line: UIColor { return UIColor(red: 72/255, green: 87/255, blue: 106/255, alpha: 1) }
        static var textSub: UIColor { return UIColor(red: 130/255, green: 131/255, blue: 155/255, alpha: 1) }
    }
    
    struct IndexPhaiSinh {
        static var cellBackground: UIColor { return UIColor (hexString: "#414378")}
        static var textGiaBan: UIColor { return UIColor(hexString: "#82839b") }
        static var top10PriceGreen: UIColor { return UIColor(hexString: "#50c978").withAlphaComponent(0.7) }
        static var top10PriceRed: UIColor { return UIColor(hexString: "#d95564").withAlphaComponent(0.7) }
        static var top10PriceBackground: UIColor { return UIColor(hexString: "#383951") }
        
        static var tradeStatusTatCa : UIColor { return UIColor(red: 238/255, green: 75/255, blue: 80/255, alpha: 1) }
        static var tradeStatusDaKhop : UIColor { return UIColor(red: 99/255, green: 249/255, blue: 36/255, alpha: 1) }
        static var tradeStatusChoKhop : UIColor { return UIColor(red: 49/255, green: 200/255, blue: 227/255, alpha: 1) }
        static var tradeStatusDaHuy : UIColor { return UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1) }
    }
}
