//
//  PopupView.swift
//  PodoRang
//
//  Created by coco on 2023/06/28.
//

import UIKit
import SnapKit

class PopupView: UIView {
    let infoView = UIView()
    let mainLabel = UILabel()
    let mainImage = UIImageView()
    let infoLabel = UILabel()
    let closeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        infoView.backgroundColor = .white
        infoView.clipsToBounds = true
        infoView.layer.cornerRadius = 10
        
        mainLabel.text = "🍇 press the grape,\n you can paint the grape"
        mainLabel.font = .boldSystemFont(ofSize: 18)
        mainLabel.textColor = CustomColor.navigationTitle
        mainLabel.numberOfLines = 2
        mainLabel.setLineSpacing(spacing: 2)
        mainLabel.textAlignment = .center
        
        mainImage.image = UIImage(named: "podo")
        
        infoLabel.text = "하루 한번 목표를 달성해 \n 포도를 채워주세요."
        infoLabel.font = .systemFont(ofSize: 14)
        infoLabel.numberOfLines = 2
        infoLabel.setLineSpacing(spacing: 5)
        infoLabel.textAlignment = .center
        
        closeButton.setTitle("CLOSE", for: .normal)
        closeButton.tintColor = .white
        closeButton.backgroundColor = CustomColor.mainPurple
        closeButton.clipsToBounds = true
        closeButton.layer.cornerRadius = 10

        self.addSubview(infoView)
        infoView.addSubviews([mainLabel, mainImage, infoLabel, closeButton])
    }
    
    func setupConstraints() {
        infoView.snp.makeConstraints {
            $0.height.equalTo(350)
            $0.width.equalTo(230)
            $0.centerX.centerY.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.top).offset(30)
            $0.leading.trailing.equalTo(infoView).inset(10)
        }
        
        mainImage.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(infoView).inset(72)
            $0.height.equalTo(106)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(mainImage.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(infoView).inset(35)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(25)
            $0.leading.trailing.equalTo(infoView).inset(55)
        }
    }
}
