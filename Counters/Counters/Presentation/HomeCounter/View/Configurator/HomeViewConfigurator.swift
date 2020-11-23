//
//  HomeViewConfigurator.swift
//  Counters
//
//  Created by Jhonatahan on 11/20/20.
//

import Foundation

protocol HomeViewConfiguratorProtocol{
    func configure(controller: HomeViewController)
}

class HomeViewConfigurator: HomeViewConfiguratorProtocol{
    func configure(controller: HomeViewController) {
        let interactorStorageData = StorageDataInteractor(repository: StorageDataRepository())
        let interactorCounter = CounterInteractor(repository: CounterRepository())
        let router = HomeViewRouter(controller: controller)
        controller.presenter = HomeViewPresenter(view: controller, interactorStorageData: interactorStorageData, router: router, interactorCounter: interactorCounter)
    }
    
    
}
