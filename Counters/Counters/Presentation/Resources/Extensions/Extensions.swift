//
//  Extensions.swift
//  Counters
//
//  Created by Jhonatahan on 11/19/20.
//

import UIKit

enum FontSizeApp: CGFloat {
    case p12 = 33.0
    case p14 = 17.0
}

extension UILabel{
    func setCustomFont(size: FontSizeApp, color: ColorsApp, customFont: FontsApp) {
        self.font = UIFont(name: customFont.rawValue, size: size.rawValue)
        self.textColor = UIColor(named: color.rawValue)
    }
}
