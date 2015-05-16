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

    private func configureStyles() {
        let preferredHeadline = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        textLabel?.font = UIFont(name: "Helvetica-Bold", size: preferredHeadline.pointSize)

        let preferredCaption = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
        detailTextLabel?.font = UIFont(name: "HelveticaNeue", size: preferredCaption.pointSize)
    }
}
