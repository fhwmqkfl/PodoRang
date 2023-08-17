//
//  DetailView.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import UIKit
import SnapKit

class DetailView: UIView {
    let lineView = UIView()
    let mainLabel = UILabel()
    let mainImageView = UIImageView()
    let modifyButton = UIButton()
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
        self.addSubviews([lineView, mainLabel, mainImageView, modifyButton, historyLabel, detailTableView])
        
        lineView.backgroundColor = .systemGray5
        
        mainLabel.backgroundColor = CustomColor.mainPurple
        mainLabel.font = .boldSystemFont(ofSize: 15)
        mainLabel.textAlignment = .center
        mainLabel.textColor = .white
        mainLabel.clipsToBounds = true
        mainLabel.layer.cornerRadius = 20
        
        setLabel(historyLabel, title: "date of painting Grains")
        
        setButton(modifyButton, title: "Modify Grape")
    }
    
    func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        lineView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeArea)
            $0.height.equalTo(1)
        }
        
        mainLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(15)
            $0.leading.equalTo(safeArea).offset(25)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        mainImageView.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(15)
            $0.width.equalTo(240)
            $0.height.equalTo(mainImageView.snp.width).multipliedBy(1.3)
            $0.centerX.equalToSuperview()
        }
        
        modifyButton.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(safeArea).inset(25)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(35)
        }
        
        historyLabel.snp.makeConstraints {
            $0.top.equalTo(modifyButton.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        
        detailTableView.snp.makeConstraints {
            $0.top.equalTo(historyLabel.snp.bottom).offset(15)
            $0.bottom.equalTo(safeArea).offset(-15)
            $0.leading.trailing.equalTo(safeArea).inset(25)
        }
    }
    
    func setLabel(_ label: UILabel, title: String) {
        label.text = title.localized()
        label.textColor = CustomColor.infoGreen
        label.font = .boldSystemFont(ofSize: 15)
    }
    
    func setButton(_ button: UIButton, title: String) {
        button.backgroundColor = CustomColor.buttonGreen
        button.setTitle(title.localized(), for: .normal)
        button.tintColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
    }
}
