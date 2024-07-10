//
//  AddReminderDateViewController.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/3/24.
//

import UIKit

final class AddReminderDateViewController: BaseViewController {
    weak var dateDelegate: PassDateProtocol?
    private let viewModel = AddReminderViewModel()
    
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
        
        bindData()
        configureBackNavi(action: #selector(customBackTapped))
    }
    private func bindData() {
        viewModel.outputDate.bind { [weak self] date in
            guard let self else { return }
            self.date = date
        }
        viewModel.outputBackBtn.bind { [weak self] value in
            guard let self else { return }
            print(value, "☄️")
            // Observable 초기값으로 무조건 nil을 주게되니까 조건문으로 처리를 해주지 않으면 바로 코드 실행됨.
            if value != nil {
                self.dateDelegate?.passDate(self.date)
                navigationController?.popViewController(animated: true)
            } else {
                print("여기")
            }
        }
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
        viewModel.inputDatePickerTrigger.value = datePicker.date
    }
    @objc private func customBackTapped() {
        print(#function)
        // backBtnTapped이 호출되었을 때, nil이 아닌 빈 튜플을 넘겨주는데용
        viewModel.inputBackBtnTrigger.value = ()
    }
}
