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
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = Constant.Font.regular14
        label.textColor = Constant.Color.darkGray
        return label
    }()
    
    private let chevronImgView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysOriginal)
        image.tintColor = Constant.Color.black
        return image
    }()
    
    override func configureHierarchy() {
        [titleLabel, contentLabel, chevronImgView]
            .forEach { contentView.addSubview($0) }
    }
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(Constant.Spacing.twelve.toCGFloat)
            make.height.equalTo(20)
        }
        contentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing)
            make.trailing.equalTo(chevronImgView.snp.leading).inset(-Constant.Spacing.eight.toCGFloat)
            make.height.equalTo(20)
        }
        chevronImgView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Constant.Spacing.twelve.toCGFloat)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(17)
            
        }
    }
    func configureUI(labelTitle: String, content: String?) {
        titleLabel.text = labelTitle
        contentLabel.text = content
    }
}
