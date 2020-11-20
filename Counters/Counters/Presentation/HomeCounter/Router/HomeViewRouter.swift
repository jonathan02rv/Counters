//
//  HomeViewRouter.swift
//  Counters
//
//  Created by Jhonatahan on 11/19/20.
//

import Foundation

protocol HomeViewRouterProtocol{
    var customView: HomeViewController?{get set}
}

class HomeViewRouter: HomeViewRouterProtocol{
    weak var customView: HomeViewController?
    
    init(controller: HomeViewController) {
        self.customView = controller
    }
}
