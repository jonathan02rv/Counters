//
//  ExampleCollectionViewCell.swift
//  Counters
//
//  Created by Jhonatahan on 11/23/20.
//

import UIKit

class ExampleCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblTitle: UILabel!
            
    static let identifier = "exampleCollectionViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "ExampleCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupViewCell()
        setFontCell()
    }
    
    var title:String?{
        didSet{
            lblTitle.text = title
        }
    }
    
    
    func setupViewCell() {
        backgroundColor = .clear
        viewCell.layer.cornerRadius = 15
        viewCell.backgroundColor = .white
    }
    
    private func setFontCell(){
        lblTitle.setCustomFont(size: .s17, color: .primaryBlackColorApp, customFont: .regular)
    }

}
