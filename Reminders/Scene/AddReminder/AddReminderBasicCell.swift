//
//  AddReminderBasicCell.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/3/24.
//

import UIKit

final class AddReminderBasicCell: BaseTableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constant.Font.regular14
        label.textColor = Constant.Color.black
        return label
    }()
    private let chevronImgView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysOriginal)
        image.tintColor = .black
        return image
    }()
    
    override func configureHierarchy() {
        [titleLabel, chevronImgView]
            .forEach { contentView.addSubview($0) }
    }
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(Constant.Spacing.twelve.toCGFloat)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(20)
        }
        chevronImgView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Constant.Spacing.twelve.toCGFloat)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(20)
            
        }
    }
    func configureUI(labelTitle: String) {
        titleLabel.text = labelTitle
    }
}
