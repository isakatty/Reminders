//
//  ReminderListDetailViewController.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/7/24.
//

import UIKit
import PhotosUI

protocol ReminderDetailCellPassDataProtocol: AnyObject {
    func passTitleText(_ text: String?)
    func passContentText(_ text: String?)
}

final class ReminderListDetailViewController: BaseViewController {
    var reminder: Reminder
    var index: Int
    private var naviEnable: Bool = false
    private var changedImg: Bool = false
    private var newReminder = Reminder(title: "", content: "", date: Date(), tag: "", priority: "", imageStr: "")
    private var changedTag: String?
    private var changedPriority: Priority?
    private var changedDate: Date?
    private var changedImage: UIImage?
    private var changedTitle: String?
    private var changedContent: String?
    
    weak var finishedDelegate: ReminderFinishedProtocol?
    
    private lazy var detailTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.register(ReminderDetailTitleCell.self, forCellReuseIdentifier: ReminderDetailTitleCell.identifier)
        tableView.register(ReminderDetailContentCell.self, forCellReuseIdentifier: ReminderDetailContentCell.identifier)
        tableView.register(ReminderDetailFlagCell.self, forCellReuseIdentifier: ReminderDetailFlagCell.identifier)
        tableView.register(ReminderDetailPhotoCell.self, forCellReuseIdentifier: ReminderDetailPhotoCell.identifier)
        tableView.register(AddReminderBasicCell.self, forCellReuseIdentifier: AddReminderBasicCell.identifier)
        return tableView
    }()
    
    init(reminder: Reminder, index: Int) {
        self.reminder = reminder
        self.index = index
        
        changedTag = reminder.tag
        changedPriority = reminder.priority.toPriority()
        changedDate = reminder.date
        changedTitle = reminder.title
        changedContent = reminder.content
        
        super.init(viewTitle: "세부사항")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackNavi(action: #selector(leftBtnTapped))
        configureNaviRightButton(title: "저장", buttonAction: #selector(rightBtnTapped), enable: naviEnable)
        navigationController?.navigationBar.prefersLargeTitles = false
        validateChanged()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        validateChanged()
    }
    override func configureHierarchy() {
        view.addSubview(detailTableView)
    }
    override func configureLayout() {
        super.configureLayout()
        let safeArea = view.safeAreaLayoutGuide
        
        detailTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    private func validateChanged() {
        let titleChanged = changedTitle != reminder.title
        let contentChanged = changedContent != reminder.content
        let tagChanged = changedTag != reminder.tag
        let priorityChanged = changedPriority?.toString != reminder.priority
        let dateChanged = changedDate != reminder.date
        let imageChanged = changedImage != nil
        print(titleChanged, contentChanged, tagChanged, priorityChanged, dateChanged, imageChanged, "⭕️")
        naviEnable = titleChanged || contentChanged || tagChanged || priorityChanged || dateChanged || imageChanged
        
        configureNaviRightButton(title: "저장", buttonAction: #selector(rightBtnTapped), enable: naviEnable)
    }
    
    @objc private func leftBtnTapped() {
        // TODO: dismiss되기전에 기존 값이랑 비교해서 변한 값이 하나라도 있으면 Alert띄우는 방식
        dismiss(animated: true)
    }
    @objc private func rightBtnTapped() {
        print("save & dismiss", #function)
        print(changedTitle)
        ReminderRepository().updateReminder(
            reminder,
            title: changedTitle,
            content: changedContent,
            tag: changedTag,
            date: changedDate,
            isFlag: false,
            priority: changedPriority ?? .none
        )
        finishedDelegate?.fetchReminder(index: index)
        dismiss(animated: true)
        
    }
    @objc private func imgBtnTapped() {
        print(#function)
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .any(of: [.images])
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
}
extension ReminderListDetailViewController: PassDateProtocol, ReminderDetailCellPassDataProtocol {
    func passTitleText(_ text: String?) {
        if let text {
            print("?")
            changedTitle = text
            validateChanged()
        }
        print("X")
    }
    
    func passContentText(_ text: String?) {
        if let text {
            changedContent = text
        }
        validateChanged()
    }
    
    func passDate(_ date: Date) {
        print(#function)
        changedDate = date
        detailTableView.reloadData()
    }
    
    func passPriority(_ priority: Priority) {
        print(#function)
        changedPriority = priority
        detailTableView.reloadData()
    }
    
    func passTags(_ text: String?) {
        changedTag = text
        detailTableView.reloadData()
    }
    
    func passImage(_ image: UIImage?) {
        print(#function)
    }
}
// PHPickerVC 사용
extension ReminderListDetailViewController: PHPickerViewControllerDelegate {
    func picker(
        _ picker: PHPickerViewController,
        didFinishPicking results: [PHPickerResult]
    ) {
        dismiss(animated: true)
        let itemProvider = results.last?.itemProvider
        
        guard let itemProvider,
              itemProvider.canLoadObject(ofClass: UIImage.self)
        else {
            print("로드할 수 없는 상태이거나, results가 없거나")
            return
        }
        
        itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
            guard let self else { return }
            self.changedImage = image as? UIImage
            self.changedImg.toggle()
            DispatchQueue.main.async {
                self.detailTableView.reloadSections(IndexSet(integer: 1), with: .automatic)
            }
        }
        changedImg = false
    }
}


extension ReminderListDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ReminderDetailSection.allCases.count
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
        let section = ReminderDetailSection.allCases[indexPath.section]
        
        switch section {
        case .titleSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderDetailTitleCell.identifier, for: indexPath) as? ReminderDetailTitleCell else { return UITableViewCell () }
            cell.passTitleDelegate = self
            cell.configureUI(text: changedTitle ?? "")
            return cell
        case .contentSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderDetailContentCell.identifier, for: indexPath) as? ReminderDetailContentCell else { return UITableViewCell () }
            cell.passDelegate = self
            cell.configureUI(content: changedContent)
            return cell
        case .flagSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderDetailFlagCell.identifier, for: indexPath) as? ReminderDetailFlagCell else { return UITableViewCell () }
            cell.configureUI(isFlagged: reminder.isFlag)
            return cell
        case .tagSection, .dateSection, .prioritySection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddReminderBasicCell.identifier, for: indexPath) as? AddReminderBasicCell else { return UITableViewCell() }
            switch section {
            case .tagSection:
                cell.configureUI(labelTitle: section.toString, content: changedTag?.addHashTag())
            case .dateSection:
                cell.configureUI(labelTitle: section.toString, content: changedDate?.changeDateFormat())
            case .prioritySection:
                cell.configureUI(labelTitle: section.toString, content: changedPriority?.toString)
            default:
                break
            }
            return cell
        case .photoSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderDetailPhotoCell.identifier, for: indexPath) as? ReminderDetailPhotoCell else { return UITableViewCell () }
            cell.addImgBtn.addTarget(self, action: #selector(imgBtnTapped), for: .touchUpInside)
            changedImg ? cell.photoView.image = changedImage : cell.configureUI(imageStr: reminder.imageStr)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = ReminderDetailSection.allCases[indexPath.section]
        
        switch section {
        case .tagSection:
            let vc = AddReminderTagViewController(viewTitle: AddReminderSection.tag.toTitle)
            vc.tagTextField.text = reminder.tag
            vc.tagDelegate = self
            navigationController?.pushViewController(vc, animated: true)
        case .prioritySection:
            let vc = AddReminderPriorityViewController(viewTitle: AddReminderSection.priority.toTitle)
            vc.priorityDelegate = self
            vc.sheetPresentationController?.detents = [.medium()]
            present(vc, animated: true)
        case .dateSection:
            let vc = AddReminderDateViewController(viewTitle: AddReminderSection.dueDate.toTitle)
            vc.dateDelegate = self
            navigationController?.pushViewController(vc, animated: true)
        default:
            print("?")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = ReminderDetailSection.allCases[indexPath.section]
        switch section {
        case .photoSection:
            var isPhoto: Bool = false
            if reminder.imageStr != nil {
                isPhoto.toggle()
            } else {
                isPhoto = false
            }
            return isPhoto ? UITableView.automaticDimension : 60
        case .contentSection:
            return 120
        default:
            return 40
        }
    }
}
