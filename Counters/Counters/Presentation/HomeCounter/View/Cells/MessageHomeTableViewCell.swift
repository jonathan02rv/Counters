//
//  MessageHomeTableViewCell.swift
//  Counters
//
//  Created by Jhonatahan on 11/22/20.
//

import UIKit

enum CustomMessageType{
    case emptyCounters
    case loadCountersError
}

protocol CustomMessageViewDelegate{
    func customAction(typeMessage: CustomMessageType)
}

class MessageHomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var constWidthButton: NSLayoutConstraint!
    
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var btnAction: RoundedCornerButton!
    
    
    
    var delegate: CustomMessageViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViewCell()
        setFontCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func setupViewCell(){
        viewCell.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    
    private func setFontCell(){
        lblTitle.setCustomFont(size: .s24, color: .primaryBlackColorApp, customFont: .regular)
        lblDescription.setCustomFont(size: .s17, color: .thirdBlackColorApp, customFont: .regular)
        btnAction.type = .primary
    }
    
    
    var typeMessage: CustomMessageType?{
        didSet{
            guard let type = typeMessage else{return}
            updateFrameButton(type:type)
        }
    }
    
    private func updateFrameButton(type: CustomMessageType){
        switch type {
        case .emptyCounters:
            constWidthButton.constant = 150
        case .loadCountersError:
            constWidthButton.constant = 75
        }
    }
    
    var title:String?{
        didSet{
            lblTitle.text = title
        }
    }
    
    var message:String?{
        didSet{
            lblDescription.text = message
        }
    }
    
    var titleButtonn:String?{
        didSet{
            btnAction.setTitle(titleButtonn, for: .normal)
        }
    }
    
    
    @IBAction func customAction(_ sender: Any) {
        guard let _ = self.typeMessage else{return}
        delegate?.customAction(typeMessage: self.typeMessage!)
    }

    

    
    
}
