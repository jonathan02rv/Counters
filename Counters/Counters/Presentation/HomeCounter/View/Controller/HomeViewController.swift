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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}

extension HomeViewController: HomeViewControllerProtocol{
    
}
