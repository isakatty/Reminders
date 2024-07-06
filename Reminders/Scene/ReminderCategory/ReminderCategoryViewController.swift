//
//  ReminderCategoryViewController.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/2/24.
//

import UIKit

import RealmSwift
import SnapKit

protocol ReminderFetchProtocol: AnyObject {
    func fetchReminders(with data: [Reminder])
}

final class ReminderCategoryViewController: BaseViewController {

    let reminderRepository = ReminderRepository()
    var reminders = [Reminder]()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.register(ReminderCategoryCell.self, forCellWithReuseIdentifier: ReminderCategoryCell.identifier)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(realm.configuration.fileURL) // Realm 파일 위치 읽어오기
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    override func configureHierarchy() {
        navigationItem.leftBarButtonItem = .init(
            title: "새로운 할 일",
            image: UIImage(systemName: "plus.circle.fill"),
            target: self,
            action: #selector(addReminderTapped)
        )
        view.addSubview(collectionView)
    }
    override func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
        super.configureLayout()
    }
    private func fetchData() {
        // Realm 데이터 저장
        reminders = reminderRepository.fetchReminders()
    }

    private func collectionViewLayout() -> UICollectionViewLayout {
        // compositional layout
        // 1. item Size 정의 -> layoutItem에 itemSize로 지정 - 2개의 column으로 구성
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // 2. groupSize 정의
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1 / 8))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.interItemSpacing = .fixed(Constant.Spacing.eight.toCGFloat)
        // 3. section은 group 사이즈로 정의
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = Constant.Spacing.eight.toCGFloat
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: Constant.Spacing.eight.toCGFloat, bottom: 0, trailing: Constant.Spacing.eight.toCGFloat)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    @objc private func addReminderTapped() {
        print("하이루")
        let vc = AddReminderViewController(viewTitle: "새로운 할 일")
        vc.fetchReminderDelegate = self
        let navi = UINavigationController(rootViewController: vc)
        navigationController?.present(navi, animated: true)
    }
}
extension ReminderCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return ReminderCategory.allCases.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ReminderCategoryCell.identifier,
            for: indexPath
        ) as? ReminderCategoryCell else { return UICollectionViewCell() }
        let cellInfo = ReminderCategory.allCases[indexPath.row]
        cell.configureUI(
            image: UIImage(systemName: cellInfo.categoryImgStr),
            imageTintColor: cellInfo.categoryColor,
            titleText: cellInfo.toString,
            countText: String(cellInfo.sortedReminder.count)
        )
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellInfo = ReminderCategory.allCases[indexPath.row]
        let sorted = cellInfo.sortedReminder
        // 필터된 Reminders에 대한 데이터가 들어가야함
        let vc = ReminderListViewController(reminders: sorted, viewType: cellInfo)
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension ReminderCategoryViewController: ReminderFetchProtocol {
    func fetchReminders(with data: [Reminder]) {
        reminders = data
        collectionView.reloadData()
    }
}
