//
//  CounterTableViewCell.swift
//  Counters
//
//  Created by Jhonatahan on 11/21/20.
//

import UIKit

class CounterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var viewSeparator: UIView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var stpCounter: UIStepper!
    
    var presenter: HomeViewPresenterProtocol!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViewCell()
        setFontCell()
    }
    
    private func setupViewCell(){
        viewCell.layer.cornerRadius = 10
        viewCell.backgroundColor = .primaryWhiteColorApp
        viewSeparator.backgroundColor = .secundaryGraceColorApp
        contentView.backgroundColor = .secundaryGraceColorApp
        stpCounter.maximumValue = Double(Constants.maxIncement)
        stpCounter.layer.cornerRadius = 10
        stpCounter.backgroundColor = .primaryWhiteColorApp
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var row:Int = 0{
        didSet{
            stpCounter.value = Double(presenter.getValueCount(row: row))
        }
    }
    
    var title:String?{
        didSet{
            self.lblTitle.text = title
        }
    }
    
    var count:Int?{
        didSet{
            guard let itemCount = count else{return}
            self.lblCount.text = "\(itemCount)"
            valiateCountColor(itemCount: itemCount)
        }
    }
    @IBAction func stepper(_ sender: UIStepper) {
        presenter.setValueCount(value: sender.value, row: self.row)
        count = Int(sender.value)
    }
    
    
    func valiateCountColor(itemCount: Int){
        if itemCount > 0{
            lblCount.textColor = .primaryOrangeColorApp
        }else{
            lblCount.textColor = .secundaryGraceColorApp
        }
    }
    
    private func setFontCell(){
        lblCount.setCustomFont(size: .s24, color: .secundaryGraceColorApp, customFont: .bold)
        lblTitle.setCustomFont(size: .s17, color: .primaryBlackColorApp, customFont: .regular)
    }
}
