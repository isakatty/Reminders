//
//  BaseCollectionViewCell.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/3/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
