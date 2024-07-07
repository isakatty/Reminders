//
//  ReminderDetailFlagCell.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/7/24.
//

import UIKit

final class ReminderDetailFlagCell: BaseTableViewCell {
    private let flagLabel: UILabel = {
        let label = UILabel()
        label.text = "깃발"
        label.textAlignment = .left
        label.font = Constant.Font.regular14
        label.textColor = Constant.Color.black
        return label
    }()
    lazy var toggleBtn: UISwitch = {
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(toggleChanged), for: .valueChanged)
        return toggle
    }()
    
    override func configureHierarchy() {
        [flagLabel, toggleBtn]
            .forEach { contentView.addSubview($0) }
    }
    override func configureLayout() {
        flagLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constant.Spacing.four.toCGFloat)
            make.leading.equalToSuperview().inset(Constant.Spacing.twelve.toCGFloat)
        }
        toggleBtn.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(Constant.Spacing.four.toCGFloat)
            make.trailing.equalToSuperview().inset(Constant.Spacing.twelve.toCGFloat)
            make.leading.greaterThanOrEqualTo(flagLabel.snp.trailing)
        }
    }
    
    @objc private func toggleChanged(_ sender: UISwitch) {
        print(sender.isOn)
    }
    
    func configureUI(isFlagged: Bool) {
        toggleBtn.isOn = isFlagged
    }
}
