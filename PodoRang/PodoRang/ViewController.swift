//
//  ViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUI()
        getUserData()
    }
    
    func setUI() {
        mainLabel.font = .boldSystemFont(ofSize: 20)
        mainImage.layer.cornerRadius = mainImage.frame.width / 2
        mainImage.layer.borderWidth = 1
        mainImage.layer.borderColor = UIColor.systemPurple.cgColor
        mainImage.contentMode = .scaleAspectFill
        mainImage.clipsToBounds = true
    }
    
    func getUserData() {
        if let userName = UserDefaults.standard.string(forKey: "userName"), let userImage = UserDefaults.standard.data(forKey: "userImage") {
            mainLabel.text = "안녕하세요 \(userName)님"
            loadImage(UIImage: userImage)

        } else {
            print("데이터를 가져오는데 실패했습니다")
        }
    }
    
    func loadImage(UIImage value: Data) {
        if let image = UIImage(data: value) {
            mainImage.image = image
        }
    }
}

