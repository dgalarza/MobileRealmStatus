//
//  RealmsTableViewController.swift
//  MobileRealmStatus
//
//  Created by Damian Galarza on 5/4/15.
//  Copyright (c) 2015 dgalarza. All rights reserved.
//

import UIKit

class RealmsTableViewController: UITableViewController, UISearchResultsUpdating {
    var realms = [Realm]()
    var filteredRealms = [Realm]()
    var searchResultController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchResultController = setupSearchBar()
        retrieveRealms()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmsForTable().count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Realm", forIndexPath: indexPath) as! RealmTableViewCell

        let realm = realmsForTable()[indexPath.row]
        cell.realm = realm
        
        return cell
    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchText)
        
        self.filteredRealms = realms.filter { searchPredicate.evaluateWithObject($0.name) }
        
        self.tableView.reloadData()
    }
    
    private func retrieveRealms() {
        let api = RealmsApi()
        api.realmStatus() { (realms: [Realm]) -> () in
            dispatch_async(dispatch_get_main_queue()) {
                self.realms = realms
                self.tableView.reloadData()
            }
        }
    }
    
    private func realmsForTable() -> [Realm] {
        if searchResultController.active {
            return self.filteredRealms
        } else {
            return self.realms
        }
    }
    
    private func setupSearchBar() -> UISearchController {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.dimsBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = controller.searchBar
        
        return controller
    }
}