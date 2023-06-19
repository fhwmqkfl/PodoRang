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
    
    enum Status: String {
        case create = "프로필 등록"
        case modify = "프로필 수정"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        
        setupUI()
        setupImageView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          view.endEditing(true)
    }
    
    func setupUI() {
        if let userName = UserDefaults.standard.string(forKey: "userName"), let userImage = UserDefaults.standard.data(forKey: "userImage") {
            nameTextField.text = userName
            loadImage(UIImage: userImage)
            mainLabel.text = Status.modify.rawValue
            saveButton.setTitle("MODIFTY", for: .normal)
        }
        
        mainLabel.font = .boldSystemFont(ofSize: 20)
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = CustomColor.mainPurple.cgColor
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
    
    func loadImage(UIImage value: Data) {
        let decoded = try! PropertyListDecoder().decode(Data.self, from: value)
        let image = UIImage(data: decoded)
        profileImageView.image = image
    }
    
    func setupImageView() {
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(showImagePickerPage))
        profileImageView.addGestureRecognizer(tabGesture)
        profileImageView.isUserInteractionEnabled = true
    }
    
    @objc func showImagePickerPage() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        if let userimage = profileImageView.image, nameTextField.text != "" {
            UserDefaults.standard.set(nameTextField.text!, forKey: "userName")
            saveImage(UIImage: userimage, forKey:"userImage")
            if mainLabel.text == Status.modify.rawValue {
                dismiss(animated: true)
            } else {
                guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController else { return }
                mainVC.modalPresentationStyle = .fullScreen
                present(mainVC, animated: true)
            }
        } else {
            let alertController = UIAlertController(title: "", message: "유저명과 이미지를 다시한번 확인해주세요", preferredStyle: UIAlertController.Style.alert)
            let checked = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(checked)
            present(alertController, animated: true)
        }
    }
    
    func saveImage(UIImage value: UIImage, forKey key: String) {
        guard let data = value.jpegData(compressionQuality: 0.5) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: key)
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
        } else {
            let alertController = UIAlertController(title: "", message: "이미지를 가져오는데 실패했습니다", preferredStyle: UIAlertController.Style.alert)
            let checked = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(checked)
            present(alertController, animated: true)
        }
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
