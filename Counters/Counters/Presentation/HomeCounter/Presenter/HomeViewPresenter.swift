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
    func setValueCount(value: Double, id: String)
    func getValueCount(row:Int)->Int
    func getValueFilterCount(row:Int)->Int
    func getListCounters()
    func callRetryService(typeError: TypErrorCounter, homeData: CounterModel, value: Int)
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
    
    func getValueFilterCount(row:Int)->Int{
        return filterData[row].count
    }
    
    func setValueCount(value: Double, id: String){
        guard let itemData = homeData.first(where: {$0.id == id}) else{return}
        let intValue = Int(value)
        if itemData.count < intValue{
            incrementCounter(homeData: itemData, value: intValue)
        }else{
            decrementCounter(homeData: itemData, value: intValue)
        }
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
        self.view?.startLoading()
        getListCounters()
    }
    
    func getListCounters(){
        self.interactorCounter.getCountersAll { [weak self](result) in
            guard let sweak = self else {return}
            sweak.view?.finishLoading()
            switch result{
            case .success(let data):
                sweak.homeData = data
                sweak.view?.reloadData()
                break
            case .failure(let error):
                print("\(error)")
                
                guard let errorModel =  error as? ErrorModel else {
                    print("ERROR: \(error.localizedDescription)")
                    return
                }
                switch errorModel.type {
                case .networkError:
                    print("ERROR: \(errorModel.description ?? "")")
                case .custom:
                    print("ERROR: \(errorModel.description ?? "")")
                case .unknownError:
                    print("ERROR: \(errorModel.description ?? "")")
                default:
                    break
                }
            }
        }
    }
    
    func incrementCounter(homeData: CounterModel, value: Int){
        self.view?.startLoading()
        interactorCounter.incrementCounter(counterId: homeData.id) { [weak self](result) in
            guard let sweak = self else {return}
            sweak.view?.finishLoading()
            switch result{
            case .success(let data):
                sweak.homeData = data
                sweak.view?.reloadData()
                break
            case .failure(let error):
                print("\(error)")
                guard let errorModel =  error as? ErrorModel else {
                    print("ERROR: \(error.localizedDescription)")
                    return
                }
                switch errorModel.type {
                case .networkError,.custom,.unknownError,.parseModel:
                    let strAppend = "\"\(homeData.title)\"\("counterTo".localized)\(value)"
                    sweak.view?.showAlert(typeAlert: .increment, messageData: (message: errorModel.description ?? "", strAppend: strAppend), homeData: homeData, value: value)
                    print("ERROR: \(errorModel.description ?? "")")
                default:
                    break
                }
            }
        }
    }
    
    func decrementCounter(homeData: CounterModel, value: Int){
        self.view?.startLoading()
        interactorCounter.decrementCounter(counterId: homeData.id) { [weak self](result) in
            guard let sweak = self else {return}
            sweak.view?.finishLoading()
            switch result{
            case .success(let data):
                sweak.homeData = data
                sweak.view?.reloadData()
                break
            case .failure(let error):
                print("\(error)")
                guard let errorModel =  error as? ErrorModel else {
                    print("ERROR: \(error.localizedDescription)")
                    return
                }
                switch errorModel.type {
                case .networkError,.custom,.unknownError,.parseModel:
                    let strAppend = "\"\(homeData.title)\"\("counterTo".localized)\(value)"
                    sweak.view?.showAlert(typeAlert: .decrement, messageData: (message: errorModel.description ?? "", strAppend: strAppend), homeData: homeData, value: value)
                    print("ERROR: \(errorModel.description ?? "")")
                default:
                    break
                }
            }
        }
    }
    
    func callRetryService(typeError: TypErrorCounter, homeData: CounterModel, value: Int) {
        switch typeError {
        case .increment:
            self.incrementCounter(homeData: homeData, value: value)
        case .decrement:
            self.decrementCounter(homeData: homeData, value: value)
        default:
            break
        }
    }
}
