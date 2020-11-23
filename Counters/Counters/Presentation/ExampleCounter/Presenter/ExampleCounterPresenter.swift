//
//  ExampleCounterPresenter.swift
//  Counters
//
//  Created by Jhonatahan on 11/23/20.
//

import Foundation

protocol ExampleCounterPresenterProtocol{
    
}

class ExampleCounterPresenter{
    private weak var view: ExampleCounterControllerProtocol?
    private var router : ExampleCounterRouterProtocol!
    
    init(view: ExampleCounterControllerProtocol?, router : ExampleCounterRouterProtocol!) {
        self.view = view
        self.router = router
    }
}


extension ExampleCounterPresenter:ExampleCounterPresenterProtocol{
    
}
