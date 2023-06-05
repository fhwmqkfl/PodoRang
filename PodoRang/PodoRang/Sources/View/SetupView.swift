//
//  SetupView.swift
//  PodoRang
//
//  Created by coco on 2023/06/05.
//

import UIKit
import SnapKit

class SetupView: UIView {
    let lineView = UIView()
    let goalLabel = UILabel()
    let goalTextField = UITextField()
    let dayLabel = UILabel()
    let dayTextField = UITextField()
    let dayPickerView = UIDatePicker()
    
    var diaryDate: Date?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(lineView)
        self.addSubview(goalLabel)
        self.addSubview(goalTextField)
        self.addSubview(dayLabel)
        self.addSubview(dayTextField)

        lineView.backgroundColor = .systemGray5
        
        goalLabel.text = "목표"
        goalLabel.font = .boldSystemFont(ofSize: 12)
        goalLabel.textColor = CustomColor.textPurpleColor
        
        goalTextField.layer.borderWidth = 1
        goalTextField.layer.borderColor = CustomColor.mainPurpleColor.cgColor
        goalTextField.layer.cornerRadius = 10
        
        dayLabel.text = "시작하는 날을 선택해 주세요"
        dayLabel.font = .boldSystemFont(ofSize: 12)
        dayLabel.textColor = CustomColor.textPurpleColor
        
        dayTextField.tintColor = .clear
        dayTextField.layer.borderWidth = 1
        dayTextField.layer.borderColor = UIColor.blue.cgColor
        dayTextField.textColor = .black
        dayTextField.textAlignment = .center
        
        dayPickerView.datePickerMode = .date
        dayPickerView.preferredDatePickerStyle = .wheels
        dayPickerView.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        dayTextField.inputView = dayPickerView
    }
    
    @objc func dateChange(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        formatter.locale = Locale(identifier: "ko_KR")
        diaryDate = datePicker.date
        dayTextField.text = formatter.string(from: datePicker.date)
    }
    
    func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        lineView.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.leading.equalTo(safeArea)
            $0.trailing.equalTo(safeArea)
            $0.height.equalTo(1)
        }
        
        goalLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(50)
            $0.leading.equalTo(safeArea).offset(47)
            $0.trailing.greaterThanOrEqualTo(safeArea).offset(-120)
        }
        
        goalTextField.snp.makeConstraints {
            $0.top.equalTo(goalLabel.snp.bottom).offset(10)
            $0.leading.equalTo(safeArea).offset(47)
            $0.trailing.equalTo(safeArea).offset(-47)
        }
        
        dayLabel.snp.makeConstraints {
            $0.top.equalTo(goalTextField.snp.bottom).offset(55)
            $0.leading.equalTo(safeArea).offset(47)
            $0.trailing.greaterThanOrEqualTo(safeArea).offset(-120)
        }
        
        dayTextField.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.bottom).offset(10)
            $0.leading.equalTo(safeArea).offset(47)
            $0.trailing.equalTo(safeArea).offset(-47)
        }
    }
}
