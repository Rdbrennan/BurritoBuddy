//
//  BurritoBuddyFonts.swift
//  BurritoBuddy
//
//  Created by Robert Brennan on 7/8/20.
//  Copyright © 2020 Creatility. All rights reserved.
//

import Foundation
import UIKit

enum BurritoBuddyFont: String {
    case robotoRegular = "Roboto-Regular"
    case robotoLight = "Roboto-Light"
    case robotoMedium = "Roboto-Medium"
    case robotoBold = "Roboto-Bold"
    case robotoThin = "Roboto-Thin"
    case HelveticaNeueBold = "HelveticaNeue-Bold"


    func of(style: UIFont.TextStyle) -> UIFont {
        let preferred = UIFont.preferredFont(forTextStyle: style).pointSize
        guard let font = UIFont(name: self.rawValue, size: preferred) else {
            assertionFailure("Font \(self.rawValue) is not installed")
            return UIFont.systemFont(ofSize: preferred)
        }
        return font
    }

    func with(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: self.rawValue, size: size) else {
            assertionFailure("Font \(self.rawValue) is not installed")
            return UIFont.systemFont(ofSize: size)        }

        return font
    }
}

enum Constants {

    static let cellSpacing: CGFloat = 8
}

enum PresentationType {

    case present
    case dismiss

    var isPresenting: Bool {
        return self == .present
    }
}
