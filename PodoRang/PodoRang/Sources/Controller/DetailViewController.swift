//
//  DetailViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import UIKit

class DetailViewController: UIViewController {
    let projectManager = ProjectManager.shared
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
        
        title = projectManager.fetch(isfinished: isFinished)[index].title
    }

}
