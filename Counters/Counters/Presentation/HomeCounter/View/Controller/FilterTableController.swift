//
//  FilterTableController.swift
//  Counters
//
//  Created by Jhonatahan on 11/20/20.
//
import UIKit

class FilterTableController: UITableViewController {
    
    let tableViewCellIdentifier = Constants.tableViewCellIdentifier
    let tableViewCellName = Constants.tableViewCellName
    
    var presenter: HomeViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: tableViewCellName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: tableViewCellIdentifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .primaryGraceColorApp
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfRowDataFilter()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as! CounterTableViewCell
        cell.presenter = self.presenter
        cell.typeCell = .dataFilterCounter
        cell.row = indexPath.row
        let itemCounter = presenter.getItemFilterData(row: indexPath.row)
        cell.idCounter = itemCounter.id
        cell.count = itemCounter.count
        cell.title = itemCounter.title
        
        return cell
    }
    
}
