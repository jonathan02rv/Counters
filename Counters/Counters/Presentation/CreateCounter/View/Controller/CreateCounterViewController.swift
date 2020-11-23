//
//  CreateCounterViewController.swift
//  Counters
//
//  Created by Jhonatahan on 11/22/20.
//

import UIKit

protocol CreateCounterViewControllerProtocol:class{
    func showAlert(typeAlert: TypErrorCounter, messageData: (message:String,strAppend:String))
    func clearInputText()
}

class CreateCounterViewController: UIViewController {
    
    @IBOutlet weak var txtCounterTitle: DesignableTextField!
    @IBOutlet weak var lblExampleTitle: UILabel!
    
    var presenter: CreateCounterPresenterProtocol!
    let configurator = CreateCounterConfigurator()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    private func initView(){
        self.configurator.configure(controller: self)
        setupItemsBar()
        setupLabels()
    }
    
    private func setupItemsBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
    }
    

    private func setupLabels(){
        txtCounterTitle.type = .primary
        txtCounterTitle.stylePlaceholder(txtPlaceholder: "PlaceHolderCrateCounter".localized)
        lblExampleTitle.setCustomFont(size: .s17, color: .thirdGraceColorApp, customFont: .regular)
        
        let exampleTapAction = UITapGestureRecognizer(target: self, action: #selector(self.exampleTap(sender:)))
        self.lblExampleTitle.isUserInteractionEnabled = true
        lblExampleTitle.addGestureRecognizer(exampleTapAction)
        
        var attributedStart = NSMutableAttributedString()
        var attributedEnd = NSMutableAttributedString()
        attributedStart = NSMutableAttributedString(string: "ExampleTextCrateCounter".localized)
        let underLineAttribute = [NSAttributedString.Key.underlineStyle:NSUnderlineStyle.thick.rawValue]
        attributedEnd = NSMutableAttributedString(string: "ExamplesTextTap".localized, attributes: underLineAttribute)
        attributedStart.append(attributedEnd)
        
        lblExampleTitle.attributedText = attributedStart
    }
    
    private func setupNavigation(){
        self.view.backgroundColor = .primaryGraceColorApp
        self.navigationItem.largeTitleDisplayMode = .never
        self.title = "CreateCounterViewTitle".localized
    }
    
    @objc func exampleTap(sender:UITapGestureRecognizer){
        presenter.goToExampleView()
    }
    
    @objc func cancelTapped(){
        presenter.routerToPrevius()
    }
    
    @objc func saveTapped(){
        guard let titleCounter = txtCounterTitle.text, !titleCounter.isEmpty else{return}
        presenter.saveNewCounnter(counterTitle: titleCounter.lowercased())
    }
}

extension CreateCounterViewController: CreateCounterViewControllerProtocol{
    
    func clearInputText(){
        self.txtCounterTitle.text = ""
    }
    
    func showAlert(typeAlert: TypErrorCounter, messageData: (message:String,strAppend:String)){
        self.showCounterAlert(typeAlert: typeAlert, messageData: messageData, action: nil)
    }
}

extension CreateCounterViewController: ExampleCounterControllerDelegate{
    func fillCounterField(title: String) {
        self.txtCounterTitle.text = title
    }
}
