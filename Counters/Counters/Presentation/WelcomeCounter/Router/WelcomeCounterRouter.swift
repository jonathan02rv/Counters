//
//  WelcomeCounterRouter.swift
//  Counters
//
//  Created by Jhonatahan on 11/19/20.
//

import UIKit


protocol WelcomeCounterRouterProtocol{
    var currentView: WelcomeCounterController? { get set }
    func routeToHome()
}

class WelcomeCounterRouter{
    weak var currentView: WelcomeCounterController?
    init(withView viewController: WelcomeCounterController) {
        self.currentView = viewController
    }
}


extension WelcomeCounterRouter: WelcomeCounterRouterProtocol{
    
    func routeToHome() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let view = currentView, let homeScreen = storyboard.instantiateInitialViewController()
        else { return }
        guard let keyWindow = UIWindow.key else{return}
        view.removeFromParent()
        homeScreen.modalPresentationStyle = .fullScreen
        keyWindow.rootViewController = homeScreen
    }
    
    
}
