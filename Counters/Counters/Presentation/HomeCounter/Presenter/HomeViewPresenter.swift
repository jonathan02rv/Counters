//
//  HomeViewPresenter.swift
//  Counters
//
//  Created by Jhonatahan on 11/19/20.
//

import Foundation

protocol HomeViewPresenterProtocol{
    
}

class HomeViewPresenter{
    weak var view: HomeViewControllerProtocol?
    var router: HomeViewRouterProtocol!
    var homeData: CounterModel?
    init(view: HomeViewControllerProtocol?, router: HomeViewRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension HomeViewPresenter: HomeViewPresenterProtocol{
    
}
