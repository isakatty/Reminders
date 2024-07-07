//
//  ReminderDetailPhotoCell.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/7/24.
//

import UIKit
import PhotosUI

final class ReminderDetailPhotoCell: BaseTableViewCell {
    var photoView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    var addImgBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("이미지 변경", for: .normal)
        btn.setTitleColor(Constant.Color.white, for: .normal)
        btn.backgroundColor = Constant.Color.black
//        btn.addTarget(self, action: #selector(imgBtnTapped), for: .touchUpInside)
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
            make.height.lessThanOrEqualTo(photoView.snp.width)
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
