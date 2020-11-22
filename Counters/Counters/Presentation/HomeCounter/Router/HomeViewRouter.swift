//
//  HomeViewRouter.swift
//  Counters
//
//  Created by Jhonatahan on 11/19/20.
//

import UIKit

protocol HomeViewRouterProtocol{
    var currentView: HomeViewController?{get set}
    func routeToCreateCounter()
}

class HomeViewRouter: HomeViewRouterProtocol{
    weak var currentView: HomeViewController?
    let storyboard = UIStoryboard(name: "CreateCounter", bundle: nil)
    init(controller: HomeViewController) {
        self.currentView = controller
    }
}


extension HomeViewRouter{
    func routeToCreateCounter(){
        guard let createCounterView = storyboard.instantiateViewController(withIdentifier: "createCounterViewController") as? CreateCounterViewController,
              let view = currentView else { return }
        
        
        view.navigationController?.pushViewController(createCounterView, animated: true)
    }
}
