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
    var mainImage = UIImageView()
    let infoLabel = UILabel()
    let modifyButton = UIButton()
    let deleteButton = UIButton()
    let horizontalStackVIew = UIStackView()
    let historyLabel = UILabel()
    let tableView = UITableView()
    
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
        self.addSubview(mainImage)
        self.addSubview(infoLabel)
        self.addSubview(horizontalStackVIew)
        horizontalStackVIew.addArrangedSubview(modifyButton)
        horizontalStackVIew.addArrangedSubview(deleteButton)
        self.addSubview(historyLabel)
        self.addSubview(tableView)
        
        mainLabel.text = "앞으로 ()개의 포도알을 채우면 완성이에요"
        mainLabel.backgroundColor = CustomColor.mainPurpleColor
        mainLabel.font = .boldSystemFont(ofSize: 15)
        mainLabel.textAlignment = .center
        mainLabel.textColor = .white
        mainLabel.clipsToBounds = true
        mainLabel.layer.cornerRadius = 20
        
        mainImage.backgroundColor = CustomColor.mainPurpleColor
        
        infoLabel.text = "🍇 포도를 누르면 포도알을 칠할 수 있어요"
        infoLabel.textColor = CustomColor.infoGreenColor
        infoLabel.font = .boldSystemFont(ofSize: 15)
        
        modifyButton.backgroundColor = CustomColor.buttonColor
        modifyButton.setTitle("목표 수정하기", for: .normal)
        modifyButton.tintColor = .white
        modifyButton.clipsToBounds = true
        modifyButton.layer.cornerRadius = 10
        
        deleteButton.backgroundColor = CustomColor.buttonColor
        deleteButton.setTitle("목표 삭제하기", for: .normal)
        deleteButton.tintColor = .white
        deleteButton.clipsToBounds = true
        deleteButton.layer.cornerRadius = 10
        
        horizontalStackVIew.axis = .horizontal
        horizontalStackVIew.spacing = 10
        horizontalStackVIew.distribution = .fillEqually
        
        historyLabel.text = "포도알을 칠한 날들"
        historyLabel.font = .boldSystemFont(ofSize: 15)
        historyLabel.textColor = CustomColor.infoGreenColor
        
        tableView.backgroundColor = CustomColor.lightPurpleColor
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 10
    }
    
    func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        mainLabel.snp.makeConstraints {
            $0.leading.equalTo(safeArea).offset(25)
            $0.top.equalTo(safeArea).offset(40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        mainImage.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(30)
            $0.width.equalTo(200)
            $0.height.equalTo(mainImage.snp.width)
            $0.centerX.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(mainImage.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        horizontalStackVIew.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(15)
            $0.leading.equalTo(safeArea).offset(25)
            $0.trailing.equalTo(safeArea).offset(-25)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(35)
        }
        
        historyLabel.snp.makeConstraints {
            $0.top.equalTo(horizontalStackVIew.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(historyLabel.snp.bottom).offset(15)
            $0.bottom.equalTo(safeArea).offset(-20)
            $0.leading.equalTo(safeArea).offset(25)
            $0.trailing.equalTo(safeArea).offset(-25)
        }
    }
}
