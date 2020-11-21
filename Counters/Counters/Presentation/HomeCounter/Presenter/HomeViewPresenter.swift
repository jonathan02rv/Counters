//
//  HomeViewPresenter.swift
//  Counters
//
//  Created by Jhonatahan on 11/19/20.
//

import Foundation

protocol HomeViewPresenterProtocol{
    func loadData()
    func getNumberOfRowData()->Int
    func getItemData(row:Int)->CounterModel
    func getNumberOfRowDataFilter()->Int
    func getItemFilterData(row:Int)->CounterModel
    func getDataArray()->[CounterModel]
    func setDataFilter(data: [CounterModel])
    func fillSearchData(searchText: String)
    func setValueCount(value: Double, row: Int)
    func getValueCount(row:Int)->Int
}

class HomeViewPresenter{
    weak var view: HomeViewControllerProtocol?
    private var interactorCounter: CounterInteractorProtocol!
    private var router: HomeViewRouterProtocol!
    
    var homeData = [CounterModel]()
    var filterData = [CounterModel]()
    
    init(view: HomeViewControllerProtocol?, router: HomeViewRouterProtocol, interactorCounter: CounterInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactorCounter = interactorCounter
    }
}

extension HomeViewPresenter: HomeViewPresenterProtocol{
    
    func getValueCount(row:Int)->Int{
        return homeData[row].count
    }
    
    func setValueCount(value: Double, row: Int){
        homeData[row].count = Int(value)
    }
    
    func clearSearchData(){
        filterData = [CounterModel]()
        view?.reloadDataFilter()
    }
    
    func fillSearchData(searchText: String){
        guard searchText.count > 0 else{
            clearSearchData()
            return
        }
        filterData = [CounterModel]()
        filterData = homeData.filter({$0.title.lowercased().contains(searchText.lowercased())})
        view?.reloadDataFilter()
    }
    
    func setDataFilter(data: [CounterModel]){
        filterData = data
    }
    
    func getDataArray()->[CounterModel]{
        return homeData
    }
    
    func getNumberOfRowData()->Int {
        return homeData.count
    }
    
    func getItemData(row:Int)->CounterModel {
        return homeData[row]
    }
    
    func getNumberOfRowDataFilter()->Int {
        return filterData.count
    }
    
    func getItemFilterData(row:Int)->CounterModel {
        return filterData[row]
    }
    
    
    func loadData() {
        getListCounters()
    }
    
    func getListCounters(){
        
        self.interactorCounter.getCountersAll { [weak self](result) in
            
            guard let sweak = self else {return}
            
            switch result{
            case .success(let data):
                sweak.homeData = data
                sweak.view?.reloadData()
                break
            case .failure(let error):
                print("\(error)")
                break
            }

        }
    }
}
