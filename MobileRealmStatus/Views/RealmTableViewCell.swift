//
//  RealmTableViewCell.swift
//  MobileRealmStatus
//
//  Created by Damian Galarza on 5/6/15.
//  Copyright (c) 2015 dgalarza. All rights reserved.
//

import UIKit

class RealmTableViewCell: UITableViewCell {
    @IBOutlet weak var realmNameLabel: UILabel!
    @IBOutlet weak var realmStatusLabel: UILabel!
    @IBOutlet weak var realmTypeLabel: UILabel!
    
    var realm: Realm! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        realmNameLabel.text = realm.name
        realmStatusLabel.text = realm.displayStatus()
        realmTypeLabel.text = realm.displayType()
    }
}
