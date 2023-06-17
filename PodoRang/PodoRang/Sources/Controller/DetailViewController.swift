//
//  DetailViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import UIKit

class DetailViewController: UIViewController {
    let detailView = DetailView()
    var index: Int?
    var isFinished: Int?
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
        
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = CustomColor.navigationTitle
        navigationController?.navigationBar.titleTextAttributes =  [.foregroundColor : CustomColor.navigationTitle]

        view.backgroundColor = .white
        
        guard let index = index, let isFinished = isFinished else { return }
        if isFinished == 0 {
            let goal = GoalManager.shared.fetchInprogress()[index]
            self.title = goal.title
        } else {
            let goal = GoalManager.shared.fetchFinished()[index]
            self.title = goal.title

        }
        
    }
}
