//
//  CounterTableViewCell.swift
//  Counters
//
//  Created by Jhonatahan on 11/21/20.
//

import UIKit

class CounterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViewCell()
    }
    
    private func setupViewCell(){
        viewCell.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var title:String?{
        didSet{
            self.lblTitle.text = title
        }
    }
    
    var count:Int?{
        didSet{
            self.lblCount.text = "\(count ?? 0)"
        }
    }
    
}
