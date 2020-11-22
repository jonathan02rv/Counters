//
//  CreateCounterRouter.swift
//  Counters
//
//  Created by Jhonatahan on 11/22/20.
//

import Foundation

protocol CreateCounterRouterProtocol {
    var currentView: CreateCounterViewController?{get set}
    func routerToPrevius()
}

class CreateCounterRouter{
    weak var currentView: CreateCounterViewController?
    
    init(controller: CreateCounterViewController) {
        self.currentView = controller
    }
}

extension CreateCounterRouter:CreateCounterRouterProtocol{
    func routerToPrevius() {
        guard let view = self.currentView else { return }
        view.navigationController?.popViewController(animated: true)
    }
}
