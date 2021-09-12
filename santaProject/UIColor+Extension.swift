//
//  UIColor+Extension.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/06.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha
        )
    }

    class var stCoolGray00: UIColor { UIColor(hex: "#FFFFFF") }
    class var stCoolGray02: UIColor { UIColor(hex: "#F7F5F5") }
    class var stCoolGray05: UIColor { UIColor(hex: "#F0EDEB") }
    class var stCoolGray10: UIColor { UIColor(hex: "#F2EDEB") }
    class var stCoolGray20: UIColor { UIColor(hex: "#EEEBEA") }
    class var stCoolGray25: UIColor { UIColor(hex: "#E5E3E2") }
    class var stCoolGray30: UIColor { UIColor(hex: "#DAD7D6") }
    class var stCoolGray40: UIColor { UIColor(hex: "#D4D1CF") }
    class var stCoolGray50: UIColor { UIColor(hex: "#CECAC9") }
    class var stCoolGray60: UIColor { UIColor(hex: "#B9B3B2") }
    class var stCoolGray70: UIColor { UIColor(hex: "#A4A1A0") }
    class var stCoolGray90: UIColor { UIColor(hex: "#645F5C") }
    class var stCoolGray120: UIColor { UIColor(hex: "#1B1612") }

    class var stWarmGray40: UIColor { UIColor(hex: "#DCD2C3") }
    class var stWarmGray80: UIColor { UIColor(hex: "#7D766B") }

    class var stGreen30: UIColor { UIColor(hex: "#38AF6B") }
    class var stGreen40: UIColor { UIColor(hex: "#09873E") }
    class var stGreen50: UIColor { UIColor(hex: "#007F36") }
    class var stGreen60: UIColor { UIColor(hex: "#00632A") }

    class var stOrange30: UIColor { UIColor(hex: "#FC7459") }
    class var stOrange40: UIColor { UIColor(hex: "#FA5D3B") }

    class var stPink: UIColor { UIColor(hex: "#F9C5CE") }
    class var stBeige: UIColor { UIColor(hex: "#FFF0E6") }


}
