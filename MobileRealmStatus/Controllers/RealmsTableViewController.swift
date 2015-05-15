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
    var searchResultsController = UISearchController()

    var dataSource: [Realm] {
        get {
            if searchResultsController.active {
                return filteredRealms
            } else {
                return realms
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultsController = setupSearch()
    }

    override func viewWillAppear(animated: Bool) {
        navigationItem.title = "All Realms"
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func refresh(sender: UIRefreshControl) {
        retrieveRealms()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Realm", forIndexPath: indexPath) as! UITableViewCell

        let realm = dataSource[indexPath.row]
        cell.textLabel?.text = realm.name
        cell.detailTextLabel?.text = realm.displayType()
        
        if let imageView = cell.imageView {
            let image = UIImage(named: "Available")
            imageView.image = image
            
        }

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let favorites = FavoritesList.sharedFavoritesList
        let realm = dataSource[indexPath.row]

        favorites.addFavorite(realm.name)
    }


    // MARK: - UISearchResultsUpdating

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchText)

        filteredRealms = realms.filter { searchPredicate.evaluateWithObject($0.name) }

        tableView.reloadData()
    }

    // MARK: Private

    private func retrieveRealms() {
        let api = RealmsApi()

        refreshControl?.beginRefreshing()

        api.realmStatus() { (realms: [Realm]) -> () in
            dispatch_async(dispatch_get_main_queue()) {
                self.realms = realms
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }

    private func setupSearch() -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false

        let searchBar = searchController.searchBar
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar

        return searchController
    }
}