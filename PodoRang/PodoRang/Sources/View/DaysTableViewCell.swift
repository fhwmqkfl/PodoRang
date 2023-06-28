//
//  DaysTableViewCell.swift
//  PodoRang
//
//  Created by coco on 2023/06/19.
//

import UIKit
import SnapKit

class DaysTableViewCell: UITableViewCell {
    static let identifier = "daysCell"
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = .clear
        addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints {
            let safeArea = self.safeAreaLayoutGuide
            $0.top.equalTo(safeArea).offset(15)
            $0.leading.trailing.equalTo(safeArea).inset(40)
        }
    }
}
