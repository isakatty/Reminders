//
//  ReminderTableViewCell.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/3/24.
//

import UIKit

final class ReminderTableViewCell: BaseTableViewCell {
    private var alreadyDid: Bool = false
    
    private lazy var checkBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseBackgroundColor = .clear
        config.image = UIImage(systemName: alreadyDid ? "circle.fill" : "circle")
        config.imagePadding = 8 // 필요에 따라 이미지 패딩을 설정할 수 있습니다.
        config.imagePlacement = .leading
        let btn = UIButton(configuration: config)
        btn.addTarget(self, action: #selector(checkBtnTapped), for: .touchUpInside)
        return btn
    }()
    private lazy var reminderTitleLabel = makeLabel(
        text: "",
        textSize: Constant.Font.regular17,
        textColor: Constant.Color.black,
        lines: 1
    )
    private lazy var reminderContentLabel = makeLabel(
        text: "",
        textSize: Constant.Font.regular15,
        textColor: Constant.Color.darkGray,
        lines: 0
    )
    private lazy var dueDateLabel = makeLabel(
        text: "",
        textSize: Constant.Font.regular15,
        textColor: Constant.Color.darkGray,
        lines: 1
    )
    
    override func configureHierarchy() {
        [checkBtn, reminderTitleLabel, reminderContentLabel, dueDateLabel]
            .forEach { contentView.addSubview($0) }
    }
    override func configureLayout() {
        super.configureLayout()
        
        checkBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.Spacing.eight.toCGFloat)
            make.leading.equalToSuperview().inset(Constant.Spacing.twelve.toCGFloat)
            make.height.equalTo(checkBtn.snp.width)
        }
        reminderTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(checkBtn.snp.top)
            make.leading.equalTo(checkBtn.snp.trailing).inset(-Constant.Spacing.twelve.toCGFloat)
            make.trailing.equalToSuperview().inset(Constant.Spacing.twelve.toCGFloat)
            make.height.equalTo(20)
        }
        reminderContentLabel.snp.makeConstraints { make in
            make.top.equalTo(reminderTitleLabel.snp.bottom).offset(Constant.Spacing.eight.toCGFloat)
            make.leading.equalTo(checkBtn.snp.trailing).inset(-Constant.Spacing.twelve.toCGFloat)
            make.trailing.equalToSuperview().inset(Constant.Spacing.twelve.toCGFloat)
        }
        dueDateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(Constant.Spacing.eight.toCGFloat)
            make.leading.equalTo(checkBtn.snp.trailing).inset(-Constant.Spacing.twelve.toCGFloat)
            make.width.greaterThanOrEqualTo(50)
            make.top.equalTo(reminderContentLabel.snp.bottom).offset(Constant.Spacing.eight.toCGFloat)
        }
    }
    
    func configureUI(
        title: String,
        content: String?,
        date: String?
    ) {
        reminderTitleLabel.text = title
        reminderContentLabel.text = content
        dueDateLabel.text = date
    }
    
    private func makeLabel(
        text: String?,
        textSize: UIFont,
        textColor: UIColor,
        lines: Int
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = textSize
        label.textColor = textColor
        label.textAlignment = .left
        label.numberOfLines = lines
        return label
    }
    @objc private func checkBtnTapped() {
        alreadyDid = !alreadyDid
        configBtn(checked: alreadyDid)
    }
    private func configBtn(checked: Bool) {
        var config = checkBtn.configuration
        config?.image = UIImage(systemName: checked ? "circle.fill" : "circle")
        checkBtn.configuration = config
    }
}

