//
//  DetailView.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import UIKit
import SnapKit

class DetailView: UIView {
    let mainLabel = UILabel()
    let mainImageView = UIImageView()
    let infoLabel = UILabel()
    let modifyButton = UIButton()
    let deleteButton = UIButton()
    let horizontalStackView = UIStackView()
    let historyLabel = UILabel()
    let detailTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(mainLabel)
        self.addSubview(mainImageView)
        self.addSubview(infoLabel)
        self.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(modifyButton)
        horizontalStackView.addArrangedSubview(deleteButton)
        self.addSubview(historyLabel)
        self.addSubview(detailTableView)
        
        mainLabel.text = "앞으로 ()개의 포도알을 채우면 완성이에요"
        mainLabel.backgroundColor = CustomColor.mainPurpleColor
        mainLabel.font = .boldSystemFont(ofSize: 15)
        mainLabel.textAlignment = .center
        mainLabel.textColor = .white
        mainLabel.clipsToBounds = true
        mainLabel.layer.cornerRadius = 20
        
        mainImageView.backgroundColor = CustomColor.mainPurpleColor
        
        setLabel(infoLabel, title: "🍇 포도를 누르면 포도알을 칠할 수 있어요")
        
        setButton(modifyButton, title: "목표 수정하기")
        setButton(deleteButton, title: "목표 삭제하기")
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        horizontalStackView.distribution = .fillEqually
        
        setLabel(historyLabel, title: "포도알을 칠한 날들")
        
        detailTableView.backgroundColor = CustomColor.lightPurpleColor
        detailTableView.clipsToBounds = true
        detailTableView.layer.cornerRadius = 10
    }
    
    func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        mainLabel.snp.makeConstraints {
            $0.leading.equalTo(safeArea).offset(25)
            $0.top.equalTo(safeArea).offset(40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        mainImageView.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(30)
            $0.width.equalTo(200)
            $0.height.equalTo(mainImageView.snp.width)
            $0.centerX.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        horizontalStackView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(15)
            $0.leading.equalTo(safeArea).offset(25)
            $0.trailing.equalTo(safeArea).offset(-25)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(35)
        }
        
        historyLabel.snp.makeConstraints {
            $0.top.equalTo(horizontalStackView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        
        detailTableView.snp.makeConstraints {
            $0.top.equalTo(historyLabel.snp.bottom).offset(15)
            $0.bottom.equalTo(safeArea).offset(-20)
            $0.leading.equalTo(safeArea).offset(25)
            $0.trailing.equalTo(safeArea).offset(-25)
        }
    }
    
    func setLabel(_ label: UILabel, title: String) {
        label.text = title
        label.textColor = CustomColor.infoGreenColor
        label.font = .boldSystemFont(ofSize: 15)
    }
    
    func setButton(_ button: UIButton, title: String) {
        button.backgroundColor = CustomColor.buttonColor
        button.setTitle(title, for: .normal)
        button.tintColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
    }
}
