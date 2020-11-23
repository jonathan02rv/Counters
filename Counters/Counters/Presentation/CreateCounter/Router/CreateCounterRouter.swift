//
//  CreateCounterRouter.swift
//  Counters
//
//  Created by Jhonatahan on 11/22/20.
//

import UIKit

protocol CreateCounterRouterProtocol {
    var currentView: CreateCounterViewController?{get set}
    func routerToPrevius()
    func routeToExampleView()
}

class CreateCounterRouter{
    weak var currentView: CreateCounterViewController?
    let storyboard = UIStoryboard(name: "ExampleCounter", bundle: nil)
    init(controller: CreateCounterViewController) {
        self.currentView = controller
    }
}

extension CreateCounterRouter:CreateCounterRouterProtocol{
    
    func routeToExampleView(){
        guard let createCounterView = storyboard.instantiateViewController(withIdentifier: "exampleCounterController") as? ExampleCounterController, let view = currentView else { return }
        let backItem = UIBarButtonItem()
        backItem.title = "CreateBackText".localized
        view.navigationItem.backBarButtonItem = backItem
        view.navigationController?.pushViewController(createCounterView, animated: true)
    }
    
    func routerToPrevius() {
        guard let view = self.currentView else { return }
        view.navigationController?.popViewController(animated: true)
    }
}
