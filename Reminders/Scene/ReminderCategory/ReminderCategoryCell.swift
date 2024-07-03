//
//  ReminderCategoryCell.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/3/24.
//

import UIKit

final class ReminderCategoryCell: BaseCollectionViewCell {
    private let containView = UIView()
    private let circleImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.tintColor = Constant.Color.white
        return image
    }()
    private lazy var titleLabel = makeLabel(font: Constant.Font.regular13, color: Constant.Color.lightGray, align: .left)
    private lazy var countLabel = makeLabel(font: Constant.Font.bold17, color: Constant.Color.white, align: .right)
    
    override func configureHierarchy() {
        [containView, titleLabel, countLabel]
            .forEach { contentView.addSubview($0) }
        containView.addSubview(circleImage)
    }
    override func configureLayout() {
        backgroundColor = Constant.Color.darkGray
        layer.cornerRadius = 10
        
        containView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(Constant.Spacing.twelve.toCGFloat)
            make.width.height.equalTo(30)
        }
        circleImage.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containView.snp.bottom).offset(Constant.Spacing.sixteen.toCGFloat)
            make.leading.trailing.equalToSuperview().inset(Constant.Spacing.twelve.toCGFloat)
            make.bottom.equalToSuperview().inset(Constant.Spacing.eight.toCGFloat)
        }
        countLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.Spacing.twelve.toCGFloat)
            make.trailing.equalToSuperview().inset(Constant.Spacing.twelve.toCGFloat)
            make.height.equalTo(30)
            make.leading.greaterThanOrEqualTo(containView.snp.trailing)
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            containView.layer.cornerRadius = containView.bounds.width / 2
        }
    }
    
    func configureUI(image: UIImage?, imageTintColor: UIColor, titleText: String, countText: String?) {
//        print(imageTintColor)
        circleImage.image = image?.withRenderingMode(.alwaysTemplate)
        circleImage.backgroundColor = .clear
        containView.backgroundColor = imageTintColor
        titleLabel.text = titleText
        countLabel.text = countText
    }
    
    private func makeLabel(font: UIFont, color: UIColor, align: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        label.textAlignment = align
        return label
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        circleImage.tintColor = .clear
    }
}
