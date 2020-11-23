//
//  WelcomeTableViewCell.swift
//  Counters
//
//  Created by Jhonatahan on 11/19/20.
//

import UIKit

class WelcomeTableViewCell: UITableViewCell {

    @IBOutlet weak var imgRectangle: UIImageView!
    @IBOutlet weak var imgInclude: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var imageContainer:String?{
        didSet{
            self.imgRectangle.image = UIImage(named: imageContainer ?? "" )
        }
    }
    
    var imageInclude:String?{
        didSet{
            self.imgInclude.image = UIImage(named: imageInclude ?? "" )
        }
    }
    
    var title:String?{
        didSet{
            self.lblTitle.text = title
        }
    }
    
    var descriptionText:String?{
        didSet{
            self.lblDescription.text = descriptionText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
