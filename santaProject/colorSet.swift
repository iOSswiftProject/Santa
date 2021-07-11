//
//  colorSet.swift
//  santaProject
//
//  Created by 이병훈 on 2021/06/16.
//

import UIKit

enum Color {
    case lightlightgray
    case greengreen
    case Toolightgray
    case searchFontGreen
}
/* color Literal로 색상 넣기*/
extension UIColor {
    static func setColor(_names: Color) -> UIColor {
        switch _names {
        case .lightlightgray:
            return #colorLiteral(red: 0.8390002847, green: 0.8323840499, blue: 0.8440586925, alpha: 1)
        case .greengreen:
            return #colorLiteral(red: 0, green: 0.8976798654, blue: 0.5678834319, alpha: 1)
        case .Toolightgray:
            return #colorLiteral(red: 0.9116986394, green: 0.9045082927, blue: 0.9171952605, alpha: 1)
        case .searchFontGreen:
            return #colorLiteral(red: 0, green: 0.4980392157, blue: 0.2117647059, alpha: 1)
        }
    }
}
