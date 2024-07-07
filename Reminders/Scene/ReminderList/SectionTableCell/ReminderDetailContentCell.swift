//
//  ReminderDetailContentCell.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/7/24.
//

import UIKit

final class ReminderDetailContentCell: BaseTableViewCell {
    private let contentTextView: UITextView = {
        let view = UITextView()
        view.font = Constant.Font.regular17
        // TODO: textView scroll 안되고 cell height이 늘어나야한다면 ?
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(contentTextView)
    }
    override func configureLayout() {
        contentTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureUI(content: String?) {
        contentTextView.text = content
    }
}
