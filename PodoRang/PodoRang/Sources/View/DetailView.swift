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
    let detailTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = CustomColor.lightPurple
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 10
        tableView.separatorColor = .white
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.register(DaysTableViewCell.self, forCellReuseIdentifier: DaysTableViewCell.identifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubviews([mainLabel,mainImageView,infoLabel,horizontalStackView, historyLabel, detailTableView])
        horizontalStackView.addArragnedSubViews([modifyButton,deleteButton])
        
        mainLabel.backgroundColor = CustomColor.mainPurple
        mainLabel.font = .boldSystemFont(ofSize: 15)
        mainLabel.textAlignment = .center
        mainLabel.textColor = .white
        mainLabel.clipsToBounds = true
        mainLabel.layer.cornerRadius = 20
        
        mainImageView.backgroundColor = CustomColor.mainPurple
        
        setLabel(infoLabel, title: "🍇 press the grapes, you can paint the grapes")
        setLabel(historyLabel, title: "date of painting grapes")
        
        setButton(modifyButton, title: "Modify Goal")
        setButton(deleteButton, title: "Delete Goal")
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        horizontalStackView.distribution = .fillEqually
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
            $0.leading.trailing.equalTo(safeArea).inset(25)
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
            $0.leading.trailing.equalTo(safeArea).inset(25)
        }
    }
    
    func setLabel(_ label: UILabel, title: String) {
        label.text = title
        label.textColor = CustomColor.infoGreen
        label.font = .boldSystemFont(ofSize: 15)
    }
    
    func setButton(_ button: UIButton, title: String) {
        button.backgroundColor = CustomColor.button
        button.setTitle(title, for: .normal)
        button.tintColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
    }
}
