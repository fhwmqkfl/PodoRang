//
//  DetailViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import UIKit

class DetailViewController: UIViewController {
    let dataManager = DataManager.shared
    var index: Int?
    var isFinished: Bool = false
    
    override func loadView() {
        view = DetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
        
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = CustomColor.navigationTitleColor
        navigationController?.navigationBar.titleTextAttributes =  [.foregroundColor : CustomColor.navigationTitleColor]

        view.backgroundColor = .white
        
        guard let index else { return }
        
        title = dataManager.fetchArray(isfinished: isFinished)[index].title
    }

}
