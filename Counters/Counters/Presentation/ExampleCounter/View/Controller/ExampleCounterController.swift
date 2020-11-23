//
//  ExampleCounterController.swift
//  Counters
//
//  Created by Jhonatahan on 11/23/20.
//

import UIKit

protocol ExampleCounterControllerProtocol:class{
    
}

class ExampleCounterController: UIViewController {
    
    var presenter: ExampleCounterPresenterProtocol!
    let configurator = ExampleCounterConfigurator()
    
    
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
    }

}

extension ExampleCounterController:ExampleCounterControllerProtocol{
    
}
