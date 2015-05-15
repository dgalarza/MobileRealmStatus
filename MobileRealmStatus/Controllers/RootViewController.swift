//
//  RootViewController.swift
//  MobileRealmStatus
//
//  Created by Damian Galarza on 5/15/15.
//  Copyright (c) 2015 dgalarza. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var realms = [Realm]()

    @IBOutlet weak var tableView: UITableView!

    var favoriteRealms: [Realm] {
        get {
            let favorites = FavoritesList.sharedFavoritesList.favorites
            return realms.filter { contains(favorites, $0.name) }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        retrieveRealms()
    }

    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        tableView.reloadData()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let realmsViewController = segue.destinationViewController as! RealmsTableViewController
        realmsViewController.realms = realms
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRealms.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Realm", forIndexPath: indexPath) as! UITableViewCell
        let realm = favoriteRealms[indexPath.row]

        cell.textLabel?.text = realm.name
        cell.detailTextLabel?.text = realm.displayType()
        
        if let imageView = cell.imageView {
            let image = UIImage(named: "Available")
            imageView.image = image
            
        }

        return cell
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
}
