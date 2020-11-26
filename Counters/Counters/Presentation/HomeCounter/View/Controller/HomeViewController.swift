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
    func showAlert(typeAlert: TypErrorCounter, messageData: (message:String,strAppend:String),counter: CounterModel, value: Int)
    func enableEditCounter(isEnable: Bool)
    func editCancell()
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
        setupNavigation()
    }
    

    private func initView(){
        self.configurator.configure(controller: self)
        presenter.loadData()
        setupTable()
        setupSearchView()
        setupItemsBar()
    }
    
    private func setupItemsBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit".localized, style: .plain, target: self, action: #selector(editTapped(sender:)))
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(sender:)))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbarItems = [spacer,add]
        navigationController?.view.tintColor = .primaryOrangeColorApp
        navigationController?.setToolbarHidden(false, animated: false)

    }
    
    @objc func addTapped(sender:UIBarButtonItem){
        
        print(sender.tag)
        
        presenter.goToCreateCounter()
    }
    
    @objc func shareTapped(sender:UIBarButtonItem){
        let dataShare = presenter.getDataForShare()
        guard dataShare.count > 0 else{return}
        let activityVC = UIActivityViewController(activityItems: dataShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC,animated:true,completion:nil)
    }
    
    @objc func trashTapped(){
        
        let strMessage = "\("Delete".localized) \(presenter.getCountSelected()) counter"
        showCounterActionSheet(strDelete: strMessage, action: { actionSheetAlert in
            self.presenter.coolDispatchFunctionDelete()
        })
        print("Trash")
    }
    
    @objc func editTapped(sender:UIBarButtonItem){
        
        
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.isEditing = !self.tableView.isEditing
        })
        
        if self.tableView.isEditing{
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SelectAll".localized, style: .plain, target: self, action: #selector(self.selectAllTapped(sender:)))
            sender.title = "Done".localized
            self.toolbarItems?.remove(at: 1)
            let trash = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(self.trashTapped))
            self.toolbarItems?.insert(trash, at: 0)
            
            let shareItem = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(self.shareTapped))
            self.toolbarItems?.append(shareItem)
            
        }else{
            sender.title = "Edit".localized
            self.navigationItem.rightBarButtonItem = nil
            self.toolbarItems?.remove(at: 2)
            self.toolbarItems?.remove(at: 0)
            let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addTapped(sender:)))
            self.toolbarItems?.append(add)
        }
        
        print("Save counter")
    }
    
    @objc func selectAllTapped(sender:UIBarButtonItem){
        
        let allCounters = presenter.getDataArray()
        guard allCounters.count > 0 else{return}
        var rowItem = -1

        guard sender.tag == 0 else{
            allCounters.forEach {
                print($0)
                rowItem += 1
                self.tableView.deselectRow(at: IndexPath(row: rowItem, section: 0), animated: true)
            }
            presenter.removeAllSelected()
            sender.title = "SelectAll".localized
            sender.tag = 0
            return
        }
        
        allCounters.forEach {
            print($0)
            rowItem += 1
            self.tableView.selectRow(at: IndexPath(row: rowItem, section: 0), animated: true, scrollPosition: .none)
            
        }
        presenter.selectedAllFillData()
        sender.title = "DeselectAll".localized
        sender.tag = 1
    }
    
    private func setupNavigation(){
        self.view.backgroundColor = .primaryGraceColorApp
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    
    private func setupTable(){
        tableView.allowsMultipleSelectionDuringEditing = true
        self.view.tintColor = .primaryOrangeColorApp
        let nib = UINib(nibName: tableViewCellName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: tableViewCellIdentifier)
        
        let nibMessage = UINib(nibName: "MessageHomeTableViewCell", bundle: nil)
        tableView.register(nibMessage, forCellReuseIdentifier: "messageHomeTableViewCell")
        
        tableView.separatorStyle = .none
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

    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? CounterTableViewCell)?.contentView.backgroundColor = .primaryGraceColorApp
    }
    
    
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
        guard let _ = tableView.cellForRow(at: indexPath) as? CounterTableViewCell else{return}
        self.selectDeselectCell(tableView: tableView, indexPath: indexPath)
        print("select")
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let _ = tableView.cellForRow(at: indexPath) as? CounterTableViewCell else{return}
        self.selectDeselectCell(tableView: tableView, indexPath: indexPath)
        print("DESELECT")
    }
    
    
    private func selectDeselectCell(tableView: UITableView, indexPath: IndexPath){
        guard let _ = tableView.cellForRow(at: indexPath) as? CounterTableViewCell else{return}
        presenter.removeAllSelected()
        if let indexs = tableView.indexPathsForSelectedRows{
            presenter.appendSelect(indexPaths:indexs)
        }
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
    func editCancell() {
        guard tableView.isEditing == true else{return}
        editTapped(sender: navigationItem.leftBarButtonItem!)
    }
    
    func enableEditCounter(isEnable: Bool) {
        navigationItem.leftBarButtonItem?.isEnabled = isEnable
    }
    
    func showAlert(typeAlert: TypErrorCounter, messageData: (message:String,strAppend:String),counter: CounterModel, value: Int){
        self.showCounterAlert(typeAlert: typeAlert, messageData: messageData, action: { actionAlert in
            self.presenter.callRetryService(typeError: typeAlert,counter: counter, value: value)
        })
    }
    
    func reloadDataFilter() {
        if let filterController = searchController.searchResultsController as? FilterTableController {
            filterController.tableView.reloadData()
        }
    }
    
    func reloadData(){
        presenter.removeAllSelected()
        self.tableView.reloadData()
    }
    
    //MARK: - LOADING
    func startLoading() {
        self.showActivity()
    }
    
    func finishLoading(){
        refreshControl?.endRefreshing()
        self.hideActivity()
    }
}

extension HomeViewController:CreateCounterViewControllerDelegate{
    func refreshCounterFromCreateView() {
        presenter.setEmptyErrorHome()
        presenter.getAllStorageCounters()
        self.reloadData()
        navigationItem.leftBarButtonItem?.isEnabled = true
    }
    
    
}

extension HomeViewController: CustomMessageViewDelegate{
    func customAction(typeMessage: CustomMessageType) {
        switch typeMessage {
        case .emptyCounters:
            presenter.goToCreateCounter()
            print("create counter")
        case .loadCountersError:
            presenter.loadData()
            print("retry load counters")
        }
    }
    
    
}
