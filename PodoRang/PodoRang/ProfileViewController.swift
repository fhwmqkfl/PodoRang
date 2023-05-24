//
//  ProfileViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/24.
//

import UIKit
import PhotosUI

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupUI() {
        mainLabel.font = .boldSystemFont(ofSize: 20)
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.systemPurple.cgColor
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
    }
}
