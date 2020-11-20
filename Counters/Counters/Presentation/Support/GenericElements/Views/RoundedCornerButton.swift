//
//  RoundedCornerButton.swift
//  Counters
//
//  Created by Jhonatahan on 11/19/20.
//

import UIKit

enum RoundedCornerButtonType {
    case primary
}

class RoundedCornerButton: UIButton{
    
    var type: RoundedCornerButtonType = .primary {
        didSet {
            setNeedsLayout()
            setPrimaryFilled()
        }
    }
    
    private func setPrimaryFilled() {
     
        DispatchQueue.main.async(execute: {
            self.setTitleColor(UIColor(named: ColorsApp.primaryWhiteColorApp.rawValue), for: .normal)
            self.titleLabel?.font = UIFont(name: FontsApp.bold.getFontName(), size: FontSizeApp.s17.rawValue)
            self.backgroundColor = UIColor(named: ColorsApp.primaryOrangeColorApp.rawValue)
            self.layer.shadowColor = UIColor.clear.cgColor
            self.setTitleShadowColor(.clear, for: .normal)
            self.layer.cornerRadius = 10
        })
    }
}
