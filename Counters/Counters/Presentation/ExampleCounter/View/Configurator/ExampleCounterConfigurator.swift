//
//  ExampleCounterConfigurator.swift
//  Counters
//
//  Created by Jhonatahan on 11/23/20.
//

import Foundation

protocol ExampleCounterConfiguratorProtocol{
    func configure(controller:ExampleCounterController)
}

class ExampleCounterConfigurator: ExampleCounterConfiguratorProtocol{
    func configure(controller: ExampleCounterController) {
        let router = ExampleCounterRouter(controller: controller)
        controller.presenter = ExampleCounterPresenter(view: controller, router: router)
    }
}
