//
//  AddReminderPriorityViewController.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/4/24.
//

import UIKit

// TODO: custom bottom sheet로 바꾸거나 pull down or pop up 으로 변경할 것.

final class AddReminderPriorityViewController: BaseViewController {
    var priorityDelegate: PassDateProtocol?
    lazy var prioritySegmented: UISegmentedControl = {
        let seg = UISegmentedControl()
        seg.addTarget(
            self,
            action: #selector(
                segmentedTapped
            ),
            for: .valueChanged
        )
        return seg
    }()
    private let priorityLabel: UILabel = {
        let label = UILabel()
        label.font = Constant.Font.regular15
        label.textAlignment = .center
        label.textColor = Constant.Color.darkGray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func configureHierarchy() {
        [prioritySegmented, priorityLabel]
            .forEach { view.addSubview($0) }
    }
    
    override func configureLayout() {
        super.configureLayout()
        let safeArea = view.safeAreaLayoutGuide
        
        prioritySegmented.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeArea)
            make.height.equalTo(44)
        }
        priorityLabel.snp.makeConstraints { make in
            make.top.equalTo(prioritySegmented.snp.bottom)
            make.bottom.horizontalEdges.equalTo(safeArea)
        }
    }
    
    override func configureView() {
        for item in Priority.allCases {
            prioritySegmented.insertSegment(
                withTitle: item.toString,
                at: item.rawValue,
                animated: true
            )
            prioritySegmented.tag = item.rawValue
        }
        prioritySegmented.selectedSegmentIndex = 3
        priorityLabel.text = Priority.allCases[prioritySegmented.selectedSegmentIndex].toString
    }
    @objc private func segmentedTapped(_ sender: UISegmentedControl) {
        priorityLabel.text = Priority.allCases[sender.selectedSegmentIndex].toString
        priorityDelegate?.passPriority(Priority.allCases[sender.selectedSegmentIndex])
        dismiss(animated: true)
    }
}
