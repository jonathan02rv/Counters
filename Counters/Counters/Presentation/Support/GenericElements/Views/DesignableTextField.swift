//
//  DesignableTextField.swift
//  Counters
//
//  Created by Jhonatahan on 11/22/20.
//

import UIKit


enum DesignableTextFieldType {
    case primary
}


class DesignableTextField: UITextField{
    
    var type: DesignableTextFieldType = .primary {
        didSet {
            setNeedsLayout()
            setPrimaryFilled()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setPrimaryFilled() {
        DispatchQueue.main.async(execute: {
            self.leftViewMode = .always
            
            self.borderStyle = .none
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
            self.leftView = view
            
            self.backgroundColor = UIColor(named: ColorsApp.primaryWhiteColorApp.rawValue)
            self.tintColor = UIColor(named: ColorsApp.primaryOrangeColorApp.rawValue)
            self.layer.shadowColor = UIColor.clear.cgColor
            self.layer.cornerRadius = 20
            
            self.font = UIFont(name: FontsApp.regular.getFontName(), size: FontSizeApp.s24.rawValue)
            self.textColor = UIColor(named: ColorsApp.primaryBlackColorApp.rawValue)

        })
    }
    
    func stylePlaceholder(txtPlaceholder: String){
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.secundaryGraceColorApp,
            NSAttributedString.Key.font : UIFont(name: FontsApp.regular.getFontName(), size: FontSizeApp.s15.rawValue)
        ]

        self.attributedPlaceholder = NSAttributedString(string: txtPlaceholder, attributes:attributes as [NSAttributedString.Key : Any])
    }
}
