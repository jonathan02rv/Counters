//
//  HomeViewPresenter.swift
//  Counters
//
//  Created by Jhonatahan on 11/19/20.
//

import Foundation

protocol HomeViewPresenterProtocol{
    func loadData()
}

class HomeViewPresenter{
    weak var view: HomeViewControllerProtocol?
    private var interactorCounter: CounterInteractorProtocol!
    private var router: HomeViewRouterProtocol!
    
    var homeData = [CounterModel]()
    
    init(view: HomeViewControllerProtocol?, router: HomeViewRouterProtocol, interactorCounter: CounterInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactorCounter = interactorCounter
    }
}

extension HomeViewPresenter: HomeViewPresenterProtocol{
    
    func loadData() {
        getListCounters()
    }
    
    func getListCounters(){
        
        self.interactorCounter.getCountersAll { [weak self](result) in
            
            guard let sweak = self else {return}
            
            switch result{
            case .success(let data):
                sweak.homeData = data
                break
            case .failure(let error):
                print("\(error)")
                break
            }

        }
    }
}
