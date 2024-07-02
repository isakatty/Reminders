//
//  BaseViewController.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/2/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    var viewTitle: String
    
    init(viewTitle: String) {
        self.viewTitle = viewTitle
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("에러 어쩌구")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTitle(title: viewTitle)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    func configureHierarchy() {
        
    }
    func configureLayout() {
        view.backgroundColor = .systemBackground
        
    }
    func configureView() {
        
    }
}
