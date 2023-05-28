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
    
    override func loadView() {
        view = DetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.setupArrayData()
        setupUI()
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
        
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = CustomColor.navigationTitleColor
        navigationController?.navigationBar.titleTextAttributes =  [.foregroundColor : CustomColor.navigationTitleColor]

        view.backgroundColor = .white
        
        guard let index else { return }
        let name = dataManager.getProgressList()[index].title
        title = name
    }

}
