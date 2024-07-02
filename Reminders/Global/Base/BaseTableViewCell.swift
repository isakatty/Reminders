//
//  BaseTableViewCell.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/2/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        
        configureHierarchy()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureHierarchy() {
    }
    func configureLayout() {
        
    }
}
