//
//  ProfileViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/24.
//

import UIKit
import PhotosUI

class ProfileViewController: UIViewController {
    enum Status: String {
        case create = "Account Setup"
        case modify = "Modify Account"
    }
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var status: Status = .create
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          view.endEditing(true)
    }
    
    func setup() {
        nameTextField.delegate = self
        setupUI()
        setupImageView()
    }
    
    func setupUI() {
        if let userName = UserDefaults.standard.string(forKey: UserDefaultsKey.userName), let userThumbnail = UserDefaults.standard.data(forKey: UserDefaultsKey.userThumbnail) {
            nameTextField.text = userName
            profileImageView.image = loadImage(data: userThumbnail)
            mainLabel.text = Status.modify.rawValue
        }
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.clear.cgColor
        profileImageView.backgroundColor = CustomColor.mainPurple
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = CustomColor.mainPurple.cgColor
        nameTextField.layer.cornerRadius = 10
        saveButton.setTitle("SAVE", for: .normal)
        saveButton.backgroundColor = CustomColor.mainPurple
        saveButton.layer.cornerRadius = 10
        saveButton.setTitleColor(.white, for: .normal)
    }
    
    func setupImageView() {
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(showImagePickerPage))
        profileImageView.addGestureRecognizer(tabGesture)
        profileImageView.isUserInteractionEnabled = true
    }
    
    func saveImage(UIImage value: UIImage, forKey key: String) {
        guard let data = value.jpegData(compressionQuality: 0.5) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: key)
    }
    
    @objc func showImagePickerPage() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        if let userThumbnail = profileImageView.image, nameTextField.text != "" {
            UserDefaults.standard.set(nameTextField.text!, forKey: "userName")
            saveImage(UIImage: userThumbnail, forKey:"userThumbnail")
            
            if status == .modify {
                dismiss(animated: true)
            } else {
                guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController else { return }
                mainVC.modalPresentationStyle = .fullScreen
                self.present(mainVC, animated: true)
            }
        } else {
            presentAlert(message: "Check user name and image")
        }
    }
}

extension ProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.profileImageView.image = image as? UIImage
                }
            }
        }
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
