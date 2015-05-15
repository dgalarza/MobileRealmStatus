//
//  RootViewController.swift
//  MobileRealmStatus
//
//  Created by Damian Galarza on 5/15/15.
//  Copyright (c) 2015 dgalarza. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    private var realms = [Realm]()

    override func viewDidLoad() {
        super.viewDidLoad()

        retrieveRealms()
    }

    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let realmsViewController = segue.destinationViewController as! RealmsTableViewController
        realmsViewController.realms = realms
    }

    private func retrieveRealms() {
        let api = RealmsApi()

        api.realmStatus() { (realms: [Realm]) -> () in
            dispatch_async(dispatch_get_main_queue()) {
                self.realms = realms
            }
        }
    }
}
