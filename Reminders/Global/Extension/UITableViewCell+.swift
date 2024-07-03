//
//  UITableViewCell+.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/2/24.
//

import UIKit

extension UITableViewCell: ReusableIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
