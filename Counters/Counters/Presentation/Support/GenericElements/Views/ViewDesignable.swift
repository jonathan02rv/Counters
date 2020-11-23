//
//  ViewDesignable.swift
//  Counters
//
//  Created by Jhonatahan on 11/23/20.
//

import UIKit

class ViewdDesignable:UIView {
    
    @IBInspectable  var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var shadowColor: UIColor = .clear {
          didSet{
            self.layer.masksToBounds = false
            self.layer.shadowOffset = CGSize(width: 0, height: 2.5)
            self.layer.shadowRadius = 6
            self.layer.shadowOpacity = 0.075
           }
    }
    
    func setStyleNormal(){
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = false
    }
}
