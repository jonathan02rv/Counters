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
    func goToCreateCounter()
    
    
    func getNumberOfRowErrorData()->Int
    func hasErrorHome()->Bool
    func getMessageDataCell(row:Int)->ErrorHomeViewData
    
    
    //MARK: - Delete Methods
    func appendSelect(indexPaths:[IndexPath])
    func removeAllSelected()
    func selectedAllFillData()
    func coolDispatchFunctionDelete()
}

class HomeViewPresenter{
    private weak var view: HomeViewControllerProtocol?
    private var interactorStorageData :StorageDataInteractorProtocol!
    private var interactorCounter: CounterInteractorProtocol!
    private var router: HomeViewRouterProtocol!
    
    var selectData = [CounterModel]()
    var errorData = [ErrorHomeViewData]()
    var homeData = [CounterModel]()
    var filterData = [CounterModel]()
    
    var arrayCallServices = [(() -> Void)]()
    
    var queue = OperationQueue()
    
    init(view: HomeViewControllerProtocol?, interactorStorageData :StorageDataInteractorProtocol!, router: HomeViewRouterProtocol, interactorCounter: CounterInteractorProtocol) {
        self.view = view
        self.interactorStorageData = interactorStorageData
        self.router = router
        self.interactorCounter = interactorCounter
    }
    
    
}

//MARK: - Core Data Methods
extension HomeViewPresenter{
    func saveListCounters(counters: [CounterModel]){
        interactorStorageData.saveListCounters(counters: counters)
    }
    
    func getAllStorageCounters(){
        self.homeData = interactorStorageData.getAllStorageCounters()
    }
    
    func updateStorageCounter(counter: CounterModel){
        interactorStorageData.updateStorageCounter(counter: counter)
    }
    
}

//MARK: - Delete Methods
extension HomeViewPresenter{
    
    func appendSelect(indexPaths:[IndexPath]){
        indexPaths.forEach {selectData.append(homeData[$0.row])}
        print(selectData)
    }
    
    func selectedAllFillData(){
        self.selectData = self.homeData
    }
    
    func removeAllSelected(){
        self.selectData.removeAll()
    }
}

//MARK: - Implement Protocol
extension HomeViewPresenter: HomeViewPresenterProtocol{
    
    func goToCreateCounter(){
        router.routeToCreateCounter()
    }
    
    func getMessageDataCell(row:Int)->ErrorHomeViewData{
        return errorData[row]
    }
    
    func getNumberOfRowErrorData()->Int{
        return errorData.count
    }
    
    func hasErrorHome()->Bool{
        return errorData.count > 0
    }
    
    func setEmptyErrorHome(){
        self.errorData = [ErrorHomeViewData]()
    }
    
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
    
    
}

//MARK: - Call Services
extension HomeViewPresenter{
    
    func coolDispatchFunctionDelete() {
        
        guard selectData.count > 0 else{return}
        let radQueue = OperationQueue()
        setEmptyErrorHome()
        
        guard selectData.count > 1 else{
            if selectData.count == 1{
                self.deleteOneCounter(idCounter: selectData[0].id)
            }
            return
        }
        
        let operation = BlockOperation{
            let group = DispatchGroup()
            
            for index in 0..<self.selectData.count{
                group.enter()
                self.interactorCounter.deteleCounter(counterId: self.selectData[index].id) { [weak self](result) in
                    guard let sweak = self else{return}
                    switch result{
                    case .success(let data):
                        
                        if index == (sweak.selectData.count - 1) {
                            DispatchQueue.main.async {
                                sweak.saveListCounters(counters: data)
                                sweak.homeData = data
                                if data.count == 0{
                                    sweak.setErrorHomeData(tymeMessage: .emptyCounters)
                                }
                                sweak.view?.reloadData()
                            }
                        }
                        
                        
                    case .failure(let error):
                        
                        if index == (sweak.selectData.count - 1){
                            DispatchQueue.main.async{
                                sweak.getAllStorageCounters()
                                if sweak.homeData.count == 0{
                                    sweak.setErrorHomeData(tymeMessage: .loadCountersError)
                                }
                                sweak.view?.reloadData()
                                guard let errorModel =  error as? ErrorModel else {
                                    print("ERROR: \(error.localizedDescription)")
                                    return
                                }
                                switch errorModel.type {
                                case .networkError,.custom,.unknownError,.parseModel:
                                    print("ERROR: \(errorModel.description ?? "")")
                                default:
                                    print(error)
                                }
                            }
                        }
                    }
                }
            }
            group.wait()
        }
        radQueue.addOperation(operation)
    }
    
    func deleteOneCounter(idCounter:String){
        self.interactorCounter.deteleCounter(counterId: idCounter) { [weak self](result) in
            guard let sweak = self else {return}
            switch result{
            case .success(let data):
                sweak.saveListCounters(counters: data)
                sweak.homeData = data
                if data.count == 0{
                    sweak.setErrorHomeData(tymeMessage: .emptyCounters)
                }
                sweak.view?.reloadData()
                print(data)
            case .failure(let error):
                sweak.getAllStorageCounters()
                if sweak.homeData.count == 0{
                    sweak.setErrorHomeData(tymeMessage: .loadCountersError)
                }
                sweak.view?.reloadData()
                guard let errorModel =  error as? ErrorModel else {
                    print("ERROR: \(error.localizedDescription)")
                    return
                }
                switch errorModel.type {
                case .networkError,.custom,.unknownError,.parseModel:
                    print("ERROR: \(errorModel.description ?? "")")
                default:
                    print(error)
                }
                
            }
            
        }
    }
    
    
    func getListCounters(){
        self.view?.enableEditCounter(isEnable: true)
        setEmptyErrorHome()
        self.interactorCounter.getCountersAll { [weak self](result) in
            guard let sweak = self else {return}
            sweak.view?.finishLoading()
            switch result{
            case .success(let data):
                sweak.saveListCounters(counters: data)
                
                sweak.homeData = data
                
                if data.count == 0{
                    sweak.setErrorHomeData(tymeMessage: .emptyCounters)
                }
                
                sweak.view?.reloadData()
                break
            case .failure(let error):
                sweak.getAllStorageCounters()
                if sweak.homeData.count == 0{
                    sweak.setErrorHomeData(tymeMessage: .loadCountersError)
                }
                sweak.view?.reloadData()
                print("\(error)")
                
                guard let errorModel =  error as? ErrorModel else {
                    print("ERROR: \(error.localizedDescription)")
                    return
                }
                switch errorModel.type {
                case .networkError,.custom,.unknownError,.parseModel:
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
                sweak.saveListCounters(counters: data)
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
                sweak.saveListCounters(counters: data)
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
    
    
    //MARK: - Support Methods
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
    
    func setErrorHomeData(tymeMessage: CustomMessageType){
        self.view?.enableEditCounter(isEnable: false)
        switch tymeMessage {
        case .emptyCounters:
            self.view?.editCancell()
            let errorData = ErrorHomeViewData(title: "NoCountersYet".localized, description: "NoCountersYetMessage".localized, titleButton: "CreateAccountTitleBtn".localized, typeMessage: tymeMessage)
            self.errorData.append(errorData)
        case .loadCountersError:
            let errorData = ErrorHomeViewData(title: "ErrorLoadCounters".localized, description: "ErrorLoadCountersMessage".localized, titleButton: "retry".localized, typeMessage: tymeMessage)
            self.errorData.append(errorData)
        }
    }
}
