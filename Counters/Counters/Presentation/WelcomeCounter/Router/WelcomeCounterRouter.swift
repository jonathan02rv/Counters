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
    let storyboard = UIStoryboard(name: "Home", bundle: nil)
    init(withView viewController: WelcomeCounterController) {
        self.currentView = viewController
    }
}


extension WelcomeCounterRouter: WelcomeCounterRouterProtocol{
    
    func routeToHome() {
        guard let homeView = storyboard.instantiateViewController(withIdentifier: "homeViewController") as? HomeViewController,
              let view = currentView,
              let keyWindow = UIWindow.key else { return }
        
        view.removeFromParent()
        
        let navController = UINavigationController(rootViewController: homeView)
        navController.navigationBar.prefersLargeTitles = true
        
        homeView.navigationItem.title = "Counters"
        navController.tabBarItem.title = "Corner Shop"
        
        let tabController = UITabBarController()
        tabController.viewControllers = [navController]
        
        keyWindow.rootViewController = tabController
    }
    

    
}
