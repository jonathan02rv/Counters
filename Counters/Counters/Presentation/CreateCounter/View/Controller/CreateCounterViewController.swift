//
//  CreateCounterViewController.swift
//  Counters
//
//  Created by Jhonatahan on 11/22/20.
//

import UIKit

protocol CreateCounterViewControllerProtocol:class{
    
}

class CreateCounterViewController: UIViewController {
    
    @IBOutlet weak var lblCounterTitle: UITextField!
    
    var presenter: CreateCounterPresenterProtocol!
    let configurator = CreateCounterConfigurator()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    private func initView(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        self.configurator.configure(controller: self)
    }
    
    private func setupNavigation(){
        self.view.backgroundColor = .primaryGraceColorApp
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "Create a counter"
    }
    
    @objc func cancelTapped(){
        presenter.routerToPrevius()
        print("Save counter")
    }
    
    @objc func saveTapped(){
        guard let titleCounter = lblCounterTitle.text, !titleCounter.isEmpty else{return}
        presenter.saveNewCounnter(counterTitle: titleCounter)
        print("Save counter")
    }
}

extension CreateCounterViewController: CreateCounterViewControllerProtocol{
    
}
