//
//  AddProjectViewController.swift
//  PodoRang
//
//  Created by coco on 2023/06/05.
//

import UIKit

class AddProjectViewController: UIViewController {
    
    override func loadView() {
        view = AddProjectView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        title = "목표 작성하기"
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = CustomColor.navigationTitle
        navigationController?.navigationBar.titleTextAttributes =  [.foregroundColor : CustomColor.navigationTitle]

        view.backgroundColor = .white
    }
}
