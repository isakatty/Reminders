//
//  AddReminderTagViewController.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/5/24.
//

import UIKit

final class AddReminderTagViewController: BaseViewController {
    weak var tagDelegate: PassDateProtocol?
    private lazy var tagTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "태그를 작성해주세요."
        tf.borderStyle = .roundedRect
        tf.font = Constant.Font.regular17
        tf.addTarget(self, action: #selector(textFieldEndEdit), for: .editingDidEndOnExit)
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackNavi(action: #selector(backBtnTapped))
    }
    
    override func configureHierarchy() {
        view.addSubview(tagTextField)
    }
    override func configureLayout() {
        super.configureLayout()
        let safeArea = view.safeAreaLayoutGuide
        
        tagTextField.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(50)
            make.horizontalEdges.equalTo(safeArea).inset(Constant.Spacing.twelve.toCGFloat)
            make.height.equalTo(50)
        }
    }
    @objc func textFieldEndEdit(_ sender: UITextField) {
        tagDelegate?.passTags(sender.text)
        navigationController?.popViewController(animated: true)
    }
    @objc override func backBtnTapped() {
        print("delegate로 값 전달하고 돌아가면 됨")
        tagDelegate?.passTags(tagTextField.text)
        super.backBtnTapped()
    }
}
