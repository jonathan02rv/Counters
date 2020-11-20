//
//  WelcomeCounterConfigurator.swift
//  Counters
//
//  Created by Jhonatahan on 11/19/20.
//

import Foundation

protocol WelcomeCounterConfiguratorProtocol{
    func configure(controller: WelcomeCounterController)
}

class WelcomeCounterConfigurator: WelcomeCounterConfiguratorProtocol{
    func configure(controller: WelcomeCounterController) {
        let router = WelcomeCounterRouter(withView: controller)
        controller.presenter = WelcomeCounterPresenter(view: controller, router: router)
    }
    
}
