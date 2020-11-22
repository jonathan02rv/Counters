//
//  CreateCounterPresenter.swift
//  Counters
//
//  Created by Jhonatahan on 11/22/20.
//

import Foundation

protocol CreateCounterPresenterProtocol{
    func routerToPrevius()
    func saveNewCounnter(counterTitle:String)
}

class CreateCounterPresenter{
    private weak var view: CreateCounterViewControllerProtocol?
    private var interactorCounter: CounterInteractorProtocol!
    private var router: CreateCounterRouterProtocol!
    
    init(view:CreateCounterViewControllerProtocol?, interactorCounter: CounterInteractorProtocol!, router: CreateCounterRouterProtocol!) {
        self.view = view
        self.interactorCounter = interactorCounter
        self.router = router
    }
}


extension CreateCounterPresenter:CreateCounterPresenterProtocol{
    func saveNewCounnter(counterTitle:String) {
        
        interactorCounter.createCounter(counterTitle: counterTitle) { [weak self](result) in
            guard let sweak = self else{return}
            
            switch result{
            case .success(let data):
                print(data)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func routerToPrevius(){
        router.routerToPrevius()
    }
}
