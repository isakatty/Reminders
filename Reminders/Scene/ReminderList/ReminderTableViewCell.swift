//
//  ReminderTableViewCell.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/3/24.
//

import UIKit

final class ReminderTableViewCell: BaseTableViewCell {
    weak var reminderDelegate: ReminderFinishedProtocol?
    
    private var alreadyDid: Bool = false
    private var index: Int = 0
    private lazy var checkBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseBackgroundColor = .clear
        config.imagePadding = 8
        config.imagePlacement = .leading
        let btn = UIButton(configuration: config)
        btn.tintColor = Constant.Color.lightGray
        btn.addTarget(self, action: #selector(checkBtnTapped), for: .touchUpInside)
        return btn
    }()
    private lazy var reminderTitleLabel = makeLabel(
        textSize: Constant.Font.regular17,
        textColor: Constant.Color.black,
        lines: 1
    )
    private lazy var reminderContentLabel = makeLabel(
        textSize: Constant.Font.regular15,
        textColor: Constant.Color.darkGray,
        lines: 0
    )
    private lazy var dueDateLabel = makeLabel(
        textSize: Constant.Font.regular15,
        textColor: Constant.Color.darkGray,
        lines: 1
    )
    private var priorityImgView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var tagLabel = makeLabel(
        textSize: Constant.Font.regular15,
        textColor: .systemBlue,
        lines: 1
    )
    
    override func configureHierarchy() {
        [checkBtn, priorityImgView, reminderTitleLabel, reminderContentLabel, dueDateLabel, tagLabel]
            .forEach { contentView.addSubview($0) }
    }
    override func configureLayout() {
        super.configureLayout()
        
        checkBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.Spacing.eight.toCGFloat)
            make.leading.equalToSuperview().inset(Constant.Spacing.twelve.toCGFloat)
            make.height.width.equalTo(30)
        }
        priorityImgView.snp.makeConstraints { make in
            make.top.equalTo(checkBtn.snp.top)
            make.leading.equalTo(checkBtn.snp.trailing).inset(-Constant.Spacing.twelve.toCGFloat)
            make.height.equalTo(20)
        }
        reminderTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(checkBtn.snp.top)
            make.leading.equalTo(priorityImgView.snp.trailing)
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
            make.top.equalTo(reminderContentLabel.snp.bottom).offset(Constant.Spacing.eight.toCGFloat)
        }
        tagLabel.snp.makeConstraints { make in
            make.leading.equalTo(dueDateLabel.snp.trailing).inset(-Constant.Spacing.twelve.toCGFloat)
            make.top.equalTo(reminderContentLabel.snp.bottom).offset(Constant.Spacing.eight.toCGFloat)
            make.trailing.equalToSuperview().inset(Constant.Spacing.twelve.toCGFloat)
            make.width.greaterThanOrEqualTo(40)
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        priorityImgView.snp.removeConstraints()
        
        if priorityImgView.image == nil {
            priorityImgView.snp.updateConstraints { make in
                make.width.equalTo(0)
                make.top.equalTo(checkBtn.snp.top)
                make.leading.equalTo(checkBtn.snp.trailing).inset(-Constant.Spacing.twelve.toCGFloat)
                make.height.equalTo(20)
            }
        } else {
            priorityImgView.snp.updateConstraints { make in
                make.width.equalTo(20) // 원하는 크기로 설정
                make.top.equalTo(checkBtn.snp.top)
                make.leading.equalTo(checkBtn.snp.trailing).inset(-Constant.Spacing.twelve.toCGFloat)
                make.height.equalTo(20)
            }
        }
    }
    
    func configureUI(
        btnTag: Int,
        priority: String,
        title: String,
        content: String?,
        date: Date?,
        tag: String?,
        isDone: Bool
    ) {
        checkBtn.tag = btnTag
        priorityImgView.image = priority.toPriority().toImage
        reminderTitleLabel.text = title
        reminderContentLabel.text = content
        dueDateLabel.text = date?.changeDateFormat()
        tagLabel.text = tag
        index = checkBtn.tag
        alreadyDid = isDone
        configBtn(checked: alreadyDid)
        updateConstraints()
    }
    
    private func makeLabel(
        textSize: UIFont,
        textColor: UIColor,
        lines: Int
    ) -> UILabel {
        let label = UILabel()
        label.font = textSize
        label.textColor = textColor
        label.textAlignment = .left
        label.numberOfLines = lines
        return label
    }
    private func configBtn(checked: Bool) {
        var config = checkBtn.configuration
        config?.image = UIImage(systemName: checked ? "circle.fill" : "circle")
        checkBtn.configuration = config
    }
    @objc private func checkBtnTapped() {
        alreadyDid = !alreadyDid
        configBtn(checked: alreadyDid)
        // bool 값 전달 -> Delegate를 통해서
        reminderDelegate?.finishedReminder(alreadyDid, index: index)
    }
}

