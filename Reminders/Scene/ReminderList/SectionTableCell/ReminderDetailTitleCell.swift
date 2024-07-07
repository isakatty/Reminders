//
//  ReminderDetailTitleCell.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/7/24.
//

import UIKit

final class ReminderDetailTitleCell: BaseTableViewCell {
    var originalTitle: String?
    weak var passTitleDelegate: ReminderDetailCellPassDataProtocol?
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = Constant.Font.regular17
        textField.delegate = self
        textField.addTarget(self, action: #selector(changedTextField), for: .editingChanged)
        return textField
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(titleTextField)
    }
    override func configureLayout() {
        titleTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func configureUI(text: String) {
        titleTextField.placeholder = text
        originalTitle = text
    }
    @objc private func changedTextField(_ sender: UITextField) {
        passTitleDelegate?.passTitleText(sender.text)
    }
}

extension ReminderDetailTitleCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = originalTitle
    }
}
