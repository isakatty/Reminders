//
//  AddReminderImageViewController.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/5/24.
//

import UIKit
import PhotosUI

final class AddReminderImageViewController: BaseViewController {
    weak var imageDelegate: PassDateProtocol?
    private lazy var takeImgBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("이미지 가져오기", for: .normal)
        btn.backgroundColor = Constant.Color.black
        btn.setTitleColor(Constant.Color.white, for: .normal)
        btn.addTarget(self, action: #selector(imgBtnTapped), for: .touchUpInside)
        return btn
    }()
    private let photoView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackNavi(action: #selector(backBtnTapped))
    }
    
    override func configureHierarchy() {
        [photoView, takeImgBtn]
            .forEach { view.addSubview($0) }
    }
    override func configureLayout() {
        super.configureLayout()
        let safeArea = view.safeAreaLayoutGuide
        
        photoView.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea)
            make.top.leading.trailing.equalTo(safeArea).inset(40)
            make.height.equalTo(photoView.snp.width).multipliedBy(1.25)
        }
        takeImgBtn.snp.makeConstraints { make in
            make.top.equalTo(photoView.snp.bottom).offset(Constant.Spacing.twelve.toCGFloat)
            make.horizontalEdges.equalTo(safeArea).inset(40)
            make.height.equalTo(30)
        }
    }
    
    @objc private func imgBtnTapped() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .any(of: [.images])
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    @objc override func backBtnTapped() {
        // delegate를 통해서 데이터 넘겨받아야함.
        print(photoView.image, #function)
        imageDelegate?.passImage(photoView.image)
        
        super.backBtnTapped()
    }
}

extension AddReminderImageViewController: PHPickerViewControllerDelegate {
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
            DispatchQueue.main.async {
                self.photoView.image = image as? UIImage
            }
        }
    }
}
