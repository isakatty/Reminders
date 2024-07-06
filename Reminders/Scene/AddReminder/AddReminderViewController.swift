//
//  AddReminderViewController.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/2/24.
//

import UIKit

protocol PassDateProtocol: AnyObject {
    func passDate(_ date: Date)
    func passPriority(_ priority: Priority)
    func passTags(_ text: String?)
    func passImage(_ image: UIImage?)
}

final class AddReminderViewController: BaseViewController {
    weak var fetchReminderDelegate: ReminderFetchProtocol?
    
    private let repository = ReminderRepository()
    private var canAdd: Bool = false
    private var newReminder = Reminder(title: "", date: Date(), priority: "")
    private var changedDate: String = ""
    private var changedSections: [String?] = .init(repeating: "", count: 4)
    private lazy var reminderTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.delegate = self
        table.dataSource = self
        table.register(
            AddReminderTextFieldTableViewCell.self,
            forCellReuseIdentifier: AddReminderTextFieldTableViewCell.identifier
        )
        table.register(
            AddReminderBasicCell.self,
            forCellReuseIdentifier: AddReminderBasicCell.identifier
        )
        table.sectionHeaderHeight = 0
        table.sectionFooterHeight = 0
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavi()
    }
    
    override func configureHierarchy() {
        view.addSubview(reminderTableView)
    }
    override func configureLayout() {
        super.configureLayout()
        let safeArea = view.safeAreaLayoutGuide
        reminderTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    private func configureNavi() {
        navigationItem.largeTitleDisplayMode = .never
        configureNaviLeftButton(
            title: "취소",
            buttonAction: #selector(cancelButtonTapped)
        )
        configureNaviRightButton(
            title: "추가",
            buttonAction: #selector(addButtonTapped),
            enable: canAdd
        )
    }
    @objc private func cancelButtonTapped() {
        print("Tapped")
        dismiss(animated: true)
    }
    @objc private func addButtonTapped() {
        do {
            // RealmDB에 저장
            try repository.createReminder(newReminder)
            fetchReminderDelegate?.fetchReminders(with: repository.fetchReminders())
            dismiss(animated: true)
        } catch {
            print(error.localizedDescription)
        }
    }
}
extension AddReminderViewController: PassDateProtocol {
    func passImage(_ image: UIImage?) {
        guard let image else {
            print("image 없음 - 저장될 필요 없음")
            return
        }
        print(image)
        // 이미지
        reloadSection(indexSet: 3)
    }
    
    func passTags(_ text: String?) {
        guard let text else {
            changedSections[1] = nil
            return
        }
        newReminder.tag = text
        print(text.addHashTag())
        changedSections[1] = text.addHashTag()
        reloadSection(indexSet: 1)
    }
    
    func passPriority(_ priority: Priority) {
        print(priority)
        newReminder.priority = priority.toString
        changedSections[2] = priority.toString
        reloadSection(indexSet: 2)
    }
    
    func passDate(_ date: Date) {
        changedDate = date.changeDateFormat()
        print(changedDate)
        changedSections[0] = changedDate
        
        // 저장은 Date - 보여주는 형태는 변환된 String
        newReminder.date = date
        reloadSection(indexSet: 0)
    }
    private func reloadSection(indexSet: Int) {
        let indexSet = IndexSet(integer: indexSet + 1)
        reminderTableView.reloadSections(indexSet, with: .automatic)
    }
}

extension AddReminderViewController
: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return AddReminderSection.allCases.count
    }
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 1
    }
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch AddReminderSection.allCases[indexPath.section] {
        case .todo:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AddReminderTextFieldTableViewCell.identifier,
                for: indexPath
            ) as? AddReminderTextFieldTableViewCell
            else { return UITableViewCell() }
            
            // title
            cell.contentsCallBack = { [weak self] title, content in
                guard let self else { return }
                guard let title = title,
                      !title.isEmpty else { return }
                
                canAdd = !canAdd
                navigationItem.rightBarButtonItem?.isEnabled = canAdd
//                print(title, content)
                newReminder.title = title
                newReminder.content = content
            }
            return cell
        case .tag, .addImage, .dueDate:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AddReminderBasicCell.identifier,
                for: indexPath
            ) as? AddReminderBasicCell else { return UITableViewCell() }
            cell.configureUI(
                labelTitle: AddReminderSection.allCases[indexPath.section].toTitle,
                content: changedSections[indexPath.section - 1]
            )
            return cell
        case .priority:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AddReminderBasicCell.identifier,
                for: indexPath
            ) as? AddReminderBasicCell else { return UITableViewCell() }
            if changedSections[indexPath.section - 1] == "" {
                cell.configureUI(
                    labelTitle: AddReminderSection.allCases[indexPath.section].toTitle,
                    content: "없음"
                )
            } else {
                cell.configureUI(
                    labelTitle: AddReminderSection.allCases[indexPath.section].toTitle,
                    content: changedSections[indexPath.section - 1]
                )
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch AddReminderSection.allCases[section] {
        case .todo:
            return 20
        default:
            return 10
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch AddReminderSection.allCases[indexPath.section] {
        case .todo:
            return UITableView.automaticDimension
        default:
            return 40
        }
    }
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let section = AddReminderSection.allCases[indexPath.section]
        switch section {
        case .dueDate:
            let vc = AddReminderDateViewController(viewTitle: section.toTitle)
            vc.dateDelegate = self
            navigationController?.pushViewController(vc, animated: true)
        case .priority:
            let vc = AddReminderPriorityViewController(viewTitle: section.toTitle)
            vc.priorityDelegate = self
            vc.sheetPresentationController?.detents = [.medium()]
            present(vc, animated: true)
        case .tag:
            let vc = AddReminderTagViewController(viewTitle: section.toTitle)
            vc.tagDelegate = self
            navigationController?.pushViewController(vc, animated: true)
        case .addImage:
            let vc = AddReminderImageViewController(viewTitle: section.toTitle)
            vc.imageDelegate = self
            navigationController?.pushViewController(vc, animated: true)
        default:
            print("아직이용")
        }
    }
}
