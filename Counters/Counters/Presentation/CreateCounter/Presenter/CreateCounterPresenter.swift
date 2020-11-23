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
    private var interactorStorageData :StorageDataInteractorProtocol!
    private var interactorCounter: CounterInteractorProtocol!
    private var router: CreateCounterRouterProtocol!
    
    init(view:CreateCounterViewControllerProtocol?, interactorStorageData :StorageDataInteractorProtocol!, interactorCounter: CounterInteractorProtocol!, router: CreateCounterRouterProtocol!) {
        self.view = view
        self.interactorStorageData = interactorStorageData
        self.interactorCounter = interactorCounter
        self.router = router
    }
}

extension CreateCounterPresenter{
    
    func saveListCounters(counters: [CounterModel]){
        interactorStorageData.saveListCounters(counters: counters)
    }

}

extension CreateCounterPresenter:CreateCounterPresenterProtocol{
    func saveNewCounnter(counterTitle:String) {
        
        interactorCounter.createCounter(counterTitle: counterTitle) { [weak self](result) in
            guard let sweak = self else{return}
            
            switch result{
            case .success(let data):
                print(data)
                sweak.view?.clearInputText()
                break
            case .failure(let error):
                
                guard let errorModel =  error as? ErrorModel else {
                    print("ERROR: \(error.localizedDescription)")
                    return
                }
                switch errorModel.type {
                case .networkError,.custom,.unknownError,.parseModel:
                    sweak.view?.showAlert(typeAlert: .create, messageData: (message: errorModel.description?.localized ?? "", strAppend: ""))
                default:
                    break
                }
            }
        }
    }
    
    func routerToPrevius(){
        router.routerToPrevius()
    }
}
