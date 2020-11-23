//
//  HeaderTableViewCell.swift
//  Counters
//
//  Created by Jhonatahan on 11/23/20.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle:UILabel!
    
    static let identifier = "headerTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "HeaderTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        lblTitle.setCustomFont(size: .s15, color: .secundaryBlackColorApp, customFont: .regular)
        // Initialization code
    }
    
    var titleHeader:String?{
        didSet{
            self.lblTitle.text = titleHeader
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
