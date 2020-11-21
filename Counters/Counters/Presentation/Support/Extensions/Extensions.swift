//
//  Extensions.swift
//  Counters
//
//  Created by Jhonatahan on 11/19/20.
//

import UIKit

enum FontSizeApp: CGFloat {
    case s17 = 17.0
    case s33 = 33.0
}

extension UILabel{
    func setCustomFont(size: FontSizeApp, color: ColorsApp, customFont: FontsApp) {
        self.font = UIFont(name: customFont.getFontName(), size: size.rawValue)
        self.textColor = UIColor(named: color.rawValue)
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
