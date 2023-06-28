//
//  PopupViewController.swift
//  PodoRang
//
//  Created by coco on 2023/06/28.
//

import UIKit

class PopupViewController: UIViewController {
    let popupView = PopupView()
    
    override func loadView() {
        view = popupView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupView.closeButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
}
