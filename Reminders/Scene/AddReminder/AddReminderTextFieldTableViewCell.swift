//
//  AddReminderTextFieldTableViewCell.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/2/24.
//

import UIKit

final class AddReminderTextFieldTableViewCell: BaseTableViewCell {
    
    private lazy var titleTextField = makeTextField(placeholder: "제목")
    private lazy var contentTextView: UITextView = {
        let view = UITextView()
        view.textAlignment = .left
        view.keyboardType = .default
        view.text = "머라고요?"
        view.delegate = self
        return view
    }()
    private let separateBar: UIView = {
        let view = UIView()
        view.backgroundColor = Constant.Color.lightGray
        return view
    }()
    
    override func configureHierarchy() {
        [titleTextField, separateBar, contentTextView]
            .forEach { contentView.addSubview($0) }
    }
    override func configureLayout() {
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.Spacing.eight.toCGFloat)
            make.leading.equalToSuperview().inset(Constant.Spacing.twelve.toCGFloat)
            make.trailing.equalToSuperview().inset(Constant.Spacing.twelve.toCGFloat)
            make.height.equalTo(30)
        }
        separateBar.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.horizontalEdges.equalTo(titleTextField)
            make.height.equalTo(1)
        }
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(separateBar.snp.bottom).inset(-Constant.Spacing.four.toCGFloat)
            make.leading.trailing.equalTo(titleTextField)
            make.height.greaterThanOrEqualTo(100)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

extension AddReminderTextFieldTableViewCell {
    private func makeTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.font = Constant.Font.regular14
        textField.textColor = Constant.Color.black
        return textField
    }
}
extension AddReminderTextFieldTableViewCell: UITextViewDelegate {
    
}
