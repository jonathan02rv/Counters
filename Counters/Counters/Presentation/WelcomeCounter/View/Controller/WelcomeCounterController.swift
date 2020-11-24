//
//  WelcomeCounterController.swift
//  Counters
//
//  Created by Jhonatahan on 11/19/20.
//

import UIKit

protocol WelcomeCounterControllerProtocol: class {
    func reloadData()
}

class WelcomeCounterController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblPresentation: UILabel!
    @IBOutlet weak var tableWelcome: UITableView!
    
    @IBOutlet weak var btnNext: RoundedCornerButton!
    
    var presenter: WelcomeCounterPresenterProtocol!
    private let configurator = WelcomeCounterConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setStyleView()
    }
    
    private func viewSetup(){
        self.configurator.configure(controller: self)
        presenter.loadData()
        setupTableView()
    }
    
    private func setStyleView(){
        lblTitle.text = "WelcomeTitle".localized
        lblSubTitle.text = "CounterTitle".localized
        lblPresentation.text = "WelcomeParagraph".localized
        
        lblTitle.setCustomFont(size: .s33, color: .primaryOrangeColorApp, customFont: .bold)
        lblSubTitle.setCustomFont(size: .s33, color: ColorsApp.primaryBlackColorApp, customFont: .bold)
        btnNext.type = .primary
    }
    
    @IBAction func btnGoToHome(_ sender: UIButton) {
        presenter.goToHome()
    }
    
    func setupTableView(){
        let nibInputText = UINib.init(nibName: "WelcomeTableViewCell", bundle: nil)
        self.tableWelcome.register(nibInputText, forCellReuseIdentifier: "WelcomeTableViewCell")
    }
}

extension WelcomeCounterController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WelcomeTableViewCell", for: indexPath) as! WelcomeTableViewCell
        guard let dataForCell = presenter.getItemData(row: indexPath.row) else{return cell}
        
        cell.imageContainer = dataForCell.iconContainer
        cell.imageInclude = dataForCell.iconInclude
        cell.title = dataForCell.title
        cell.descriptionText = dataForCell.description

        return cell
    }
    
}

extension WelcomeCounterController: WelcomeCounterControllerProtocol{
    func reloadData() {
        tableWelcome.reloadData()
    }
    
    
}
