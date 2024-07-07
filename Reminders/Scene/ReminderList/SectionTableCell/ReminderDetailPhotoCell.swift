//
//  ReminderDetailPhotoCell.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/7/24.
//

import UIKit
import PhotosUI

final class ReminderDetailPhotoCell: BaseTableViewCell {
    private var photoView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private var addImgBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("이미지 변경", for: .normal)
        btn.setTitleColor(Constant.Color.white, for: .normal)
        btn.backgroundColor = Constant.Color.black
        return btn
    }()
    
    override func configureHierarchy() {
        [photoView, addImgBtn]
            .forEach { contentView.addSubview($0) }
    }
    override func configureLayout() {
        photoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.Spacing.twelve.toCGFloat)
            make.horizontalEdges.equalToSuperview().inset(Constant.Spacing.twelve.toCGFloat)
            make.height.equalTo(photoView.snp.width).multipliedBy(0.75)
        }
        addImgBtn.snp.makeConstraints { make in
            make.top.equalTo(photoView.snp.bottom).offset(Constant.Spacing.eight.toCGFloat)
            make.horizontalEdges.bottom.equalToSuperview().inset(Constant.Spacing.twelve.toCGFloat)
        }
    }
    
    func configureUI(imageStr: String?) {
        // load 어쩌구 저쩌구
        if let imageStr {
            // load
            photoView.image = FileManagerHelper.loadImageToDocument(filename: imageStr)
        } else {
            photoView.isHidden = true
        }
    }
}

// PHPickerVC 사용
extension ReminderDetailPhotoCell: PHPickerViewControllerDelegate {
    func picker(
        _ picker: PHPickerViewController,
        didFinishPicking results: [PHPickerResult]
    ) {
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
