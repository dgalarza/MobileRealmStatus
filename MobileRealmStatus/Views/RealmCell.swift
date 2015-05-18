//
//  RealmCell.swift
//  MobileRealmStatus
//
//  Created by Damian Galarza on 5/15/15.
//  Copyright (c) 2015 dgalarza. All rights reserved.
//

import UIKit

class RealmCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        configureStyles()
    }

    var viewModel: Realm? {
        didSet {
            update()
        }
    }

    func includeStatusImage() {
        imageView?.image = UIImage(named: "Available")
    }

    private func configureStyles() {
        AppearanceManager.customizeRealmCell(self)
        textLabel?.font = UIFont.headlineFont()
        detailTextLabel?.font = UIFont.captionFont()
    }

    private func update() {
        textLabel?.text = viewModel?.name

        viewModel.map { detailTextLabel?.text = "Realm Type \($0.displayType())" }
    }
}
