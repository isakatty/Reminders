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
        // 객체 초기화는 한번만 불리게 되는데, prepareForReuse를 통해서 tintColor를 clear를 주고 있었으니 투명하게 변해서 보이지 않는 문제가 있었던 것. clear를 주고 tint를 다시 해주고 싶다면 여기서 tint 값을 다시 주면 되지만, 굳이여기서 ?
//        circleImage.tintColor = Constant.Color.white
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
        print(#function)
        
        circleImage.tintColor = Constant.Color.white
    }
}
