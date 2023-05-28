//
//  DetailViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import UIKit

class DetailViewController: UIViewController {
    var index: Int?
    
    let dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.setupArrayData()
        setupUI()
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
        
        navigationController?.navigationBar.topItem?.title = "돌아가기"
        navigationController?.navigationBar.tintColor = CustomColor.mainPurpleColor

        view.backgroundColor = .white
        
        guard let index else { return }
        let name = dataManager.getProgressList()[index].title
        title = name
    }

}
