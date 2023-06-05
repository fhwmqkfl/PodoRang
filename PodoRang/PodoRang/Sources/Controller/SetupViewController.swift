//
//  SetupViewController.swift
//  PodoRang
//
//  Created by coco on 2023/06/05.
//

import UIKit

class SetupViewController: UIViewController {
    
    override func loadView() {
        view = SetupView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        title = "목표 작성하기"
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = CustomColor.navigationTitleColor
        navigationController?.navigationBar.titleTextAttributes =  [.foregroundColor : CustomColor.navigationTitleColor]

        view.backgroundColor = .white
    }
}
