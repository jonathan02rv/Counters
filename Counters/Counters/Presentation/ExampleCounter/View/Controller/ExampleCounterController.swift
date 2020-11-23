//
//  ExampleCounterController.swift
//  Counters
//
//  Created by Jhonatahan on 11/23/20.
//

import UIKit

protocol ExampleCounterControllerDelegate {
    func fillCounterField(title:String)
}

protocol ExampleCounterControllerProtocol:class{
    
}

class ExampleCounterController: UIViewController {
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var exampleTable: UITableView!
    @IBOutlet weak var lblMessageView: UILabel!
    
    var presenter: ExampleCounterPresenterProtocol!
    let configurator = ExampleCounterConfigurator()
    var delegate: ExampleCounterControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    private func setupNavigation(){
        self.view.backgroundColor = .primaryGraceColorApp
        self.navigationItem.largeTitleDisplayMode = .never
        self.title = "ExampleTitle".localized
    }
    
    private func initView(){
        self.configurator.configure(controller: self)
        presenter.loadData()
        setupTableView()
    }
    
    private func setupTableView(){
        let nib = ExampleTableViewCell.nib()
        exampleTable.register(nib, forCellReuseIdentifier: ExampleTableViewCell.identifier)
        exampleTable.register(HeaderTableViewCell.nib(), forCellReuseIdentifier: HeaderTableViewCell.identifier)
        
        messageView.backgroundColor = .primaryGraceColorApp
        messageView.layer.borderWidth = 0.5
        messageView.layer.borderColor = UIColor.systemGray.cgColor
        exampleTable.backgroundColor = .primaryGraceColorApp
        exampleTable.delegate = self
        exampleTable.dataSource = self
        lblMessageView.text = "ExampleMessageSubtitle".localized
        lblMessageView.setCustomFont(size: .s17, color: .thirdGraceColorApp, customFont: .regular)
    }

}

extension ExampleCounterController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
        cell.titleHeader = presenter.getSectionTitle(section: section)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.getCountSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExampleTableViewCell.identifier, for: indexPath) as! ExampleTableViewCell
        cell.presenter = self.presenter
        cell.sectionCell = indexPath.section
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


extension ExampleCounterController:ExampleCounterControllerProtocol{
    
}


    
