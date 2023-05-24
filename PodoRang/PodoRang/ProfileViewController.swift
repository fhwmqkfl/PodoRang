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
        setupUI()
        setupImageView()
    }
    
    func setupUI() {
        mainLabel.font = .boldSystemFont(ofSize: 20)
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.systemPurple.cgColor
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        
        saveButton.setTitle("SAVE", for: .normal)
    }
    
    func setupImageView() {
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(test))
        profileImageView.addGestureRecognizer(tabGesture)
        profileImageView.isUserInteractionEnabled = true
    }
    
    @objc func test() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        if let userimage = profileImageView.image, nameTextField.text != "" {
            let user = UserData(username: nameTextField.text!, userImage: userimage)
            UserData.list.append(user)
            print(UserData.list)
        } else {
            print("유저명과 이미지를 다시한번 확인해주세요")
        }
    }
}

extension ProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider

        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    // 이미지 뷰에 표시
                    self.profileImageView.image = image as? UIImage
                }
            }
        } else {
            print("이미지를 가져오는데 실패했습니다")
        }
    }
    
}
