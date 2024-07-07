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
        image.contentMode = .scaleAspectFill
//        image.clipsToBounds = true
        return image
    }()
    
    private var addImgBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("이미지 변경", for: .normal)
        btn.tintColor = Constant.Color.darkGray
        btn.setTitleColor(Constant.Color.white, for: .normal)
        return btn
    }()
    
    override func configureHierarchy() {
        [photoView, addImgBtn]
            .forEach { contentView.addSubview($0) }
    }
    override func configureLayout() {
        photoView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(Constant.Spacing.twelve.toCGFloat)
            make.height.equalTo(photoView.snp.width).multipliedBy(4 / 3)
        }
    }
    
    func configureUI(imageStr: String?) {
        // load 어쩌구 저쩌구
    }
}

// PHPickerVC 사용
