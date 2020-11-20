//
//  HomeViewController.swift
//  Counters
//
//  Created by Jhonatahan on 11/19/20.
//

import UIKit

protocol HomeViewControllerProtocol:class{
    
}

class HomeViewController: UIViewController {
    
    var presenter: HomeViewPresenterProtocol!
    var configurator = HomeViewConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        self.configurator.configure(controller: self)
        presenter.loadData()
    }
}

extension HomeViewController: HomeViewControllerProtocol{
    
}
