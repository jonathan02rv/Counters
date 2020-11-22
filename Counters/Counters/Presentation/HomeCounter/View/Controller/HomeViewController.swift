//
//  HomeViewController.swift
//  Counters
//
//  Created by Jhonatahan on 11/19/20.
//

import UIKit

protocol HomeViewControllerProtocol:class, ViewProtocol{
    func reloadData()
    func reloadDataFilter()
    func showAlert(typeAlert: TypErrorCounter, messageData: (message:String,strAppend:String),homeData: CounterModel, value: Int)
}

class HomeViewController: UITableViewController {

    private var searchController: UISearchController!
    private var filterTableController: FilterTableController!
    
    let tableViewCellIdentifier = Constants.tableViewCellIdentifier
    let tableViewCellName = Constants.tableViewCellName
    
    var presenter: HomeViewPresenterProtocol!
    var configurator = HomeViewConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    

    private func initView(){
        self.configurator.configure(controller: self)
        presenter.loadData()
        setupTable()
        setupSearchView()
    }
    
    
    private func setupTable(){
        let nib = UINib(nibName: tableViewCellName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: tableViewCellIdentifier)
        
        let nibMessage = UINib(nibName: "MessageHomeTableViewCell", bundle: nil)
        tableView.register(nibMessage, forCellReuseIdentifier: "messageHomeTableViewCell")
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .primaryGraceColorApp
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.refreshData(_:)), for: .valueChanged)
    }
    
    private func setupSearchView(){
        filterTableController = FilterTableController()
        filterTableController.presenter = self.presenter
        searchController = UISearchController(searchResultsController: filterTableController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.tintColor = .primaryOrangeColorApp
        navigationController?.navigationBar.tintColor = .primaryOrangeColorApp
    }
    
    @objc func refreshData(_ refreshControl: UIRefreshControl){
        presenter.getListCounters()
    }
    
}

extension HomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        switch presenter.hasErrorHome() {
        case false:
            return presenter.getNumberOfRowData()
        case true:
            return presenter.getNumberOfRowErrorData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch presenter.hasErrorHome() {
        case false:
            let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as! CounterTableViewCell
            cell.presenter = self.presenter
            cell.typeCell = .dataCounter
            cell.row = indexPath.row
            let itemCounter = presenter.getItemData(row: indexPath.row)
            cell.idCounter = itemCounter.id
            cell.count = itemCounter.count
            cell.title = itemCounter.title
            
            return cell
        case true:
            let cell = tableView.dequeueReusableCell(withIdentifier: "messageHomeTableViewCell", for: indexPath) as! MessageHomeTableViewCell
            cell.delegate = self
            let dataForCell = presenter.getMessageDataCell(row: indexPath.row)
            cell.typeMessage = dataForCell.typeMessage
            cell.title = dataForCell.title
            cell.message = dataForCell.description
            cell.titleButtonn = dataForCell.titleButton
            return cell
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch presenter.hasErrorHome() {
        case false:
            return UITableView.automaticDimension
        case true:
            return tableView.bounds.height - 300
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("TAP")
    }
    
}

extension HomeViewController: UISearchBarDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let strippedString = searchController.searchBar.text?.trimmingCharacters(in: CharacterSet.whitespaces) else{return}
        presenter.fillSearchData(searchText: strippedString)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

extension HomeViewController: HomeViewControllerProtocol{
    func showAlert(typeAlert: TypErrorCounter, messageData: (message:String,strAppend:String),homeData: CounterModel, value: Int){
        self.showCounterAlert(typeAlert: typeAlert, messageData: messageData, action: { actionTest in
            self.presenter.callRetryService(typeError: typeAlert,homeData: homeData, value: value)
        })
    }
    
    func reloadDataFilter() {
        if let filterController = searchController.searchResultsController as? FilterTableController {
            filterController.tableView.reloadData()
        }
    }
    
    func reloadData(){
        self.tableView.reloadData()
    }
    
    //MARK: - TEST
    func startLoading() {
        self.showActivity()
    }
    
    func finishLoading(){
        refreshControl?.endRefreshing()
        self.hideActivity()
    }
}

extension HomeViewController: CustomMessageViewDelegate{
    func customAction(typeMessage: CustomMessageType) {
        switch typeMessage {
        case .emptyCounters:
            print("create counter")
        case .loadCountersError:
            presenter.loadData()
            print("retry load counters")
        }
    }
    
    
}
