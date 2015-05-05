//
//  RealmsTableViewController.swift
//  MobileRealmStatus
//
//  Created by Damian Galarza on 5/4/15.
//  Copyright (c) 2015 dgalarza. All rights reserved.
//

import UIKit

class RealmsTableViewController: UITableViewController {
    
    var realms = [Realm]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let api = RealmsApi()
        api.realmStatus() { (realms: [Realm]) -> () in
            dispatch_async(dispatch_get_main_queue()) {
                self.realms = realms
                self.tableView.reloadData()
            }
        }
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realms.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Realm", forIndexPath: indexPath) as! UITableViewCell

        let realm = realms[indexPath.row]
        cell.textLabel?.text = realm.name
        
        return cell
    }
}
