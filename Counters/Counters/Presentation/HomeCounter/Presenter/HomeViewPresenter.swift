//
//  HomeViewPresenter.swift
//  Counters
//
//  Created by Jhonatahan on 11/19/20.
//

import Foundation

protocol HomeViewPresenterProtocol{
    //MARK: - Loal Cell Methods
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
    func callRetryService(typeError: TypErrorCounter, counter: CounterModel, value: Int)
    func goToCreateCounter()
    
    //MARK: - Cell Type Error Methods
    func getNumberOfRowErrorData()->Int
    func setEmptyErrorHome()
    func hasErrorHome()->Bool
    func getMessageDataCell(row:Int)->ErrorHomeViewData
    
    //MARK: - Protocol CoreData Method
    func getAllStorageCounters()
    
    
    //MARK: - Delete Methods
    func appendSelect(indexPaths:[IndexPath])
    func removeAllSelected()
    func selectedAllFillData()
    func coolDispatchFunctionDelete()
    func getCountSelected()->Int
    func getDataForShare()->[String]
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
    
}

//MARK: - Delete Methods
extension HomeViewPresenter{
    
    func getDataForShare()->[String]{
        var dataShare = [String]()
        for item in selectData{
            dataShare.append("\(item.count)x\(item.title)")
        }
        return dataShare
    }
    
    func getCountSelected()->Int{
        return selectData.count
    }
    
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
            incrementCounter(counter: itemData, value: intValue)
        }else{
            decrementCounter(counter: itemData, value: intValue)
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
        self.view?.startLoading()
        let radQueue = OperationQueue()
        var arrayOperations = [BlockOperation]()
        setEmptyErrorHome()
        
        guard selectData.count > 1 else{
            if selectData.count == 1{
                self.deleteOneCounter(counter: selectData[0])
            }
            return
        }
        
        
        for index in 0..<self.selectData.count{
            let operation = BlockOperation{
                let group = DispatchGroup()
                group.enter()
                self.interactorCounter.deteleCounter(counterId: self.selectData[index].id) { [weak self](result) in
                    guard let sweak = self else{return}
                    switch result{
                    case .success(let data):
                        sweak.homeData = data
                        print("SUCCESS:\(data)")
                    case .failure(let error):
                        print("ERROR:\(error)")
                    }
                    group.leave()
                }
                group.wait()
            }
            arrayOperations.append(operation)
        }
        
        let operationRefreshView = BlockOperation{
            DispatchQueue.main.async {
                self.view?.finishLoading()
                self.saveListCounters(counters: self.homeData)
                if self.homeData.count == 0{
                    self.setErrorHomeData(tymeMessage: .emptyCounters)
                }
                self.view?.reloadData()
            }
        }
        arrayOperations.append(operationRefreshView)
        
        for index in 0..<arrayOperations.count{
            if index > 0{
                arrayOperations[index].addDependency(arrayOperations[index-1])
            }
            radQueue.addOperation(arrayOperations[index])
        }
    }
    
    
    func deleteOneCounter(counter:CounterModel){
        self.interactorCounter.deteleCounter(counterId: counter.id) { [weak self](result) in
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
            case .failure(let error):
                sweak.getAllStorageCounters()
                guard let errorModel =  error as? ErrorModel else {
                    print("ERROR: \(error.localizedDescription)")
                    return
                }
                switch errorModel.type {
                case .networkError,.custom,.unknownError,.parseModel:
                    let strAppend = "\"\(counter.title)\""
                    sweak.view?.showAlert(typeAlert: .delete, messageData: (message: errorModel.description ?? "", strAppend: strAppend), counter: counter, value: counter.count)
                    print("ERROR: \(errorModel.description ?? "")")
                default:
                    print(error)
                }
                sweak.view?.reloadData()
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
            case .failure(let error):
                sweak.getAllStorageCounters()
                guard let errorModel =  error as? ErrorModel else {
                    print("ERROR: \(error.localizedDescription)")
                    return
                }
                switch errorModel.type {
                case .networkError:
                    if sweak.homeData.count == 0{
                        sweak.setErrorHomeData(tymeMessage: .loadCountersError, "networkConnectionError")
                    }
                case .custom,.unknownError,.parseModel:
                    print("ERROR: \(errorModel.description ?? "")")
                    if sweak.homeData.count == 0{
                        sweak.setErrorHomeData(tymeMessage: .loadCountersError, "defaultError")
                    }
                default:
                    print("\(error)")
                }
                sweak.view?.reloadData()
            }
        }
    }
    
    
    
    func incrementCounter(counter: CounterModel, value: Int){
        self.view?.startLoading()
        interactorCounter.incrementCounter(counterId: counter.id) { [weak self](result) in
            guard let sweak = self else {return}
            sweak.view?.finishLoading()
            switch result{
            case .success(let data):
                sweak.saveListCounters(counters: data)
                sweak.homeData = data
                sweak.view?.reloadData()
                sweak.updateDataFilter(counter: counter)
            case .failure(let error):
                print("\(error)")
                guard let errorModel =  error as? ErrorModel else {
                    print("ERROR: \(error.localizedDescription)")
                    return
                }
                switch errorModel.type {
                case .networkError,.custom,.unknownError,.parseModel:
                    let strAppend = "\"\(counter.title)\"\("counterTo".localized)\(value)"
                    sweak.view?.showAlert(typeAlert: .increment, messageData: (message: errorModel.description ?? "", strAppend: strAppend), counter: counter, value: value)
                    print("ERROR: \(errorModel.description ?? "")")
                default:
                    break
                }
            }
        }
    }
    
    func updateDataFilter(counter: CounterModel){
        guard let counterData = homeData.first(where: {$0.id == counter.id}) else{return}
        for index in 0..<filterData.count{
            if filterData[index].id == counter.id{
                filterData[index] = counterData
            }
        }
        view?.reloadDataFilter()
    }
    
    func decrementCounter(counter: CounterModel, value: Int){
        self.view?.startLoading()
        interactorCounter.decrementCounter(counterId: counter.id) { [weak self](result) in
            guard let sweak = self else {return}
            sweak.view?.finishLoading()
            switch result{
            case .success(let data):
                sweak.saveListCounters(counters: data)
                sweak.homeData = data
                sweak.view?.reloadData()
                sweak.updateDataFilter(counter: counter)
            case .failure(let error):
                print("\(error)")
                guard let errorModel =  error as? ErrorModel else {
                    print("ERROR: \(error.localizedDescription)")
                    return
                }
                switch errorModel.type {
                case .networkError,.custom,.unknownError,.parseModel:
                    let strAppend = "\"\(counter.title)\"\("counterTo".localized)\(value)"
                    sweak.view?.showAlert(typeAlert: .decrement, messageData: (message: errorModel.description ?? "", strAppend: strAppend), counter: counter, value: value)
                    print("ERROR: \(errorModel.description ?? "")")
                default:
                    break
                }
            }
        }
    }
    
    
    //MARK: - Support Methods
    func callRetryService(typeError: TypErrorCounter, counter: CounterModel, value: Int) {
        switch typeError {
        case .increment:
            self.incrementCounter(counter: counter, value: value)
        case .decrement:
            self.decrementCounter(counter: counter, value: value)
        default:
            break
        }
    }
    
    func setErrorHomeData(tymeMessage: CustomMessageType, _ message: String = "NoCountersYetMessage"){
        self.view?.enableEditCounter(isEnable: false)
        switch tymeMessage {
        case .emptyCounters:
            self.view?.editCancell()
            let errorData = ErrorHomeViewData(title: "NoCountersYet".localized, description: message.localized, titleButton: "CreateAccountTitleBtn".localized, typeMessage: tymeMessage)
            self.errorData.append(errorData)
        case .loadCountersError:
            let errorData = ErrorHomeViewData(title: "ErrorLoadCounters".localized, description: message.localized, titleButton: "retry".localized, typeMessage: tymeMessage)
            self.errorData.append(errorData)
        }
    }
}
