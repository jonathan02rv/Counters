//
//  CreateCounterConfigurator.swift
//  Counters
//
//  Created by Jhonatahan on 11/22/20.
//

import Foundation

protocol CreateCounterConfiguratorProtocol{
    func configure(controller: CreateCounterViewController)
}

class CreateCounterConfigurator: CreateCounterConfiguratorProtocol {
    func configure(controller: CreateCounterViewController) {
        let interactorStorageData = StorageDataInteractor(repository: StorageDataRepository())
        let interactorCounter = CounterInteractor(repository: CounterRepository())
        let router = CreateCounterRouter(controller: controller)
        controller.presenter = CreateCounterPresenter(view: controller, interactorStorageData: interactorStorageData, interactorCounter: interactorCounter, router: router)
    }
    
    
    
}
