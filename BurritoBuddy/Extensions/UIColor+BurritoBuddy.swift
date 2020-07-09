//
//  UIColor+BurritoBuddy.swift
//  BurritoBuddy
//
//  Created by Robert Brennan on 7/8/20.
//  Copyright © 2020 Creatility. All rights reserved.
//

import Foundation

import UIKit

extension UIColor{

    enum BurritoBuddyColor:Int {

        // Basic Colors

        case almostBlack = 0x31353B
        case almostWhite = 0xFDFDFD
        case lightGray = 0xDEDEDE
        case veryLightGray = 0xF8F8F8
        case teal = 0x5ECAC6
        case tealPressed = 0x479996
        case tealInactive = 0xCCECEB
        case grayBackground = 0xE7E7E7
        case topBarGray = 0xF7F7F7
        case inactiveGray = 0xAEAEAE
        case black20Percent = 0xCCCCCC
        case warningRed = 0xDF3A86
        case lightRed = 0xFFA4A4
        case red = 0xEB5757
        case redPressed = 0xD14D4D
    }

    convenience init(red: Int, green: Int, blue: Int, alpha:CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    //RGB Color Value
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: CGFloat(r / 255), green: CGFloat(g / 255), blue: CGFloat(b / 255), alpha: CGFloat(1))
    }


    convenience init(netHex:Int, withAlpha alpha:CGFloat) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff, alpha: alpha)
    }

    convenience init(BurritoBuddyColor: BurritoBuddyColor, withAlpha alpha:CGFloat = 1) {
        self.init(netHex: BurritoBuddyColor.rawValue, withAlpha: alpha)
    }

}

