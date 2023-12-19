//
//  UIFont+FSBase.swift
//  RemoteHearingIOS
//
//  Created by 冯顺 on 2023/12/18.
//

import Foundation
import UIKit

extension UIFont {

    static func navigationTitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 17.0)
    }

    static func titleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 17.0)
    }

    static func descriptionFont() -> UIFont {
        return UIFont.systemFont(ofSize: 14.0)
    }
}

// MARK: All Fonts

extension UIFont {

    static func allSystemFontsNames() -> [String] {
        var fontsNames = [String]()
        let fontFamilies = UIFont.familyNames
        for fontFamily in fontFamilies {
            let fontsForFamily = UIFont.fontNames(forFamilyName: fontFamily)
            for fontName in fontsForFamily {
                fontsNames.append(fontName)
            }
        }
        return fontsNames
    }
}
