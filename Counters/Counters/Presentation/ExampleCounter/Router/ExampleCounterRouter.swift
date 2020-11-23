//
//  ExampleCounterRouter.swift
//  Counters
//
//  Created by Jhonatahan on 11/23/20.
//

import Foundation

protocol ExampleCounterRouterProtocol {
    var currentView: ExampleCounterController?{get set}
    func routerToPrevius()
}

class ExampleCounterRouter{
    weak var currentView: ExampleCounterController?
    
    init(controller: ExampleCounterController) {
        self.currentView = controller
    }
}

extension ExampleCounterRouter: ExampleCounterRouterProtocol{
    func routerToPrevius() {
        guard let view = self.currentView else { return }
        view.navigationController?.popViewController(animated: true)
    }
    
    
    
}
