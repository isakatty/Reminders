//
//  AddReminderDateViewController.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/3/24.
//

import UIKit

final class AddReminderDateViewController: BaseViewController {
    weak var dateDelegate: PassDateProtocol?
    private var date: Date = Date()
    private lazy var datePicker: UIDatePicker = {
        let date = UIDatePicker()
        date.preferredDatePickerStyle = .inline
        date.locale = Locale(identifier: "ko_KR")
        date.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        return date
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackNavi(action: #selector(customBackTapped))
    }
    
    override func configureHierarchy() {
        view.addSubview(datePicker)
    }
    override func configureLayout() {
        super.configureLayout()
        let safeArea = view.safeAreaLayoutGuide
        
        datePicker.snp.makeConstraints { make in
            make.center.equalTo(safeArea)
            make.leading.trailing.equalTo(safeArea)
            make.height.equalTo(datePicker.snp.width).multipliedBy(1.2)
        }
    }
    @objc private func dateChanged(_ datePicker: UIDatePicker) {
        print(type(of: datePicker.date))
        date = datePicker.date
    }
    @objc private func customBackTapped() {
        dateDelegate?.passDate(date)
        navigationController?.popViewController(animated: true)
    }
}
