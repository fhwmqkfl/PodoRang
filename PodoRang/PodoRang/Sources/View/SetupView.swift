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
    let startDayLabel = UILabel()
    let startDayTextField = UITextField()
    let weekLabel = UILabel()
    let oneWeekButton = UIButton()
    let twoWeeksButton = UIButton()
    let threeWeeksButton = UIButton()
    let dayHorizontalStackView = UIStackView()
    let selectColorLabel = UILabel()
    let purpleButton = UIButton()
    let redButton = UIButton()
    let greenButton = UIButton()
    let colorHorizontalStackView = UIStackView()
    let warningLabel = UILabel()
    let saveButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        lineView.backgroundColor = .systemGray5
        
        goalLabel.text = "목표"
        goalLabel.font = .boldSystemFont(ofSize: 12)
        goalLabel.textColor = CustomColor.textPurpleColor
        
        goalTextField.layer.borderWidth = 1
        goalTextField.layer.borderColor = CustomColor.mainPurpleColor.cgColor
        goalTextField.layer.cornerRadius = 10
        
        startDayLabel.text = "시작하는 날을 선택해 주세요"
        startDayLabel.font = .boldSystemFont(ofSize: 12)
        startDayLabel.textColor = CustomColor.textPurpleColor
        
        weekLabel.text = "포도알 갯수"
        weekLabel.font = .boldSystemFont(ofSize: 12)
        weekLabel.textColor = CustomColor.textPurpleColor
        
        startDayTextField.tintColor = .clear
        startDayTextField.layer.borderWidth = 1
        startDayTextField.layer.borderColor = UIColor.blue.cgColor
        startDayTextField.textColor = .black
        startDayTextField.textAlignment = .center
        
        oneWeekButton.setTitle("7days", for: .normal)
        oneWeekButton.setTitleColor(.black, for: .normal)
        oneWeekButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        oneWeekButton.layer.borderColor = CustomColor.mainPurpleColor.cgColor
        oneWeekButton.layer.borderWidth = 1
        oneWeekButton.layer.cornerRadius = 15
        
        twoWeeksButton.setTitle("14days", for: .normal)
        twoWeeksButton.setTitleColor(.black, for: .normal)
        twoWeeksButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        twoWeeksButton.layer.borderColor = CustomColor.mainPurpleColor.cgColor
        twoWeeksButton.layer.borderWidth = 1
        twoWeeksButton.layer.cornerRadius = 15
        
        threeWeeksButton.setTitle("21days", for: .normal)
        threeWeeksButton.setTitleColor(.black, for: .normal)
        threeWeeksButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        threeWeeksButton.layer.borderColor = CustomColor.mainPurpleColor.cgColor
        threeWeeksButton.layer.borderWidth = 1
        threeWeeksButton.layer.cornerRadius = 15
        
        dayHorizontalStackView.axis = .horizontal
        dayHorizontalStackView.spacing = 15
        dayHorizontalStackView.distribution = .fillEqually
        
        selectColorLabel.text = "포도 종류"
        selectColorLabel.font = .boldSystemFont(ofSize: 12)
        selectColorLabel.textColor = CustomColor.textPurpleColor
        
        purpleButton.setTitle("포도", for: .normal)
        purpleButton.setTitleColor(.black, for: .normal)
        purpleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        purpleButton.layer.borderColor = CustomColor.mainPurpleColor.cgColor
        purpleButton.layer.borderWidth = 1
        purpleButton.layer.cornerRadius = 15
        
        redButton.setTitle("적포도", for: .normal)
        redButton.setTitleColor(.black, for: .normal)
        redButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        redButton.layer.borderColor = CustomColor.mainPurpleColor.cgColor
        redButton.layer.borderWidth = 1
        redButton.layer.cornerRadius = 15
        
        greenButton.setTitle("청포도", for: .normal)
        greenButton.setTitleColor(.black, for: .normal)
        greenButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        greenButton.layer.borderColor = CustomColor.mainPurpleColor.cgColor
        greenButton.layer.borderWidth = 1
        greenButton.layer.cornerRadius = 15
        
        colorHorizontalStackView.axis = .horizontal
        colorHorizontalStackView.spacing = 15
        colorHorizontalStackView.distribution = .fillEqually
        
        warningLabel.text = "포도알 갯수와 포도 종류는 설정하면 변경할 수 없어요!"
        warningLabel.textColor = CustomColor.warningRedColor
        warningLabel.font = .boldSystemFont(ofSize: 12)
        warningLabel.textAlignment = .center
        
        saveButton.setTitle("SAVE", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = CustomColor.mainPurpleColor
        saveButton.layer.borderColor = CustomColor.mainPurpleColor.cgColor
        saveButton.layer.borderWidth = 1
        saveButton.layer.cornerRadius = 15
        
    }
    
    func addSubviews() {
        self.addSubview(lineView)
        self.addSubview(goalLabel)
        self.addSubview(goalTextField)
        self.addSubview(startDayLabel)
        self.addSubview(weekLabel)
        self.addSubview(startDayTextField)
        self.addSubview(selectColorLabel)
        self.addSubview(dayHorizontalStackView)
        dayHorizontalStackView.addArrangedSubview(oneWeekButton)
        dayHorizontalStackView.addArrangedSubview(twoWeeksButton)
        dayHorizontalStackView.addArrangedSubview(threeWeeksButton)
        self.addSubview(colorHorizontalStackView)
        colorHorizontalStackView.addArrangedSubview(purpleButton)
        colorHorizontalStackView.addArrangedSubview(redButton)
        colorHorizontalStackView.addArrangedSubview(greenButton)
        self.addSubview(warningLabel)
        self.addSubview(saveButton)
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
            $0.top.equalTo(lineView.snp.bottom).offset(42)
            $0.leading.equalTo(safeArea).offset(47)
            $0.trailing.greaterThanOrEqualTo(safeArea).offset(-120)
        }
        
        goalTextField.snp.makeConstraints {
            $0.top.equalTo(goalLabel.snp.bottom).offset(10)
            $0.leading.equalTo(safeArea).offset(47)
            $0.trailing.equalTo(safeArea).offset(-47)
        }
        
        startDayLabel.snp.makeConstraints {
            $0.top.equalTo(goalTextField.snp.bottom).offset(55)
            $0.leading.equalTo(safeArea).offset(47)
            $0.trailing.greaterThanOrEqualTo(safeArea).offset(-120)
        }
        
        startDayTextField.snp.makeConstraints {
            $0.top.equalTo(startDayLabel.snp.bottom).offset(10)
            $0.leading.equalTo(safeArea).offset(47)
            $0.trailing.equalTo(safeArea).offset(-47)
        }
        
        weekLabel.snp.makeConstraints {
            $0.top.equalTo(startDayTextField.snp.bottom).offset(55)
            $0.leading.equalTo(safeArea).offset(47)
            $0.trailing.equalTo(safeArea).offset(-47)
        }
        
        dayHorizontalStackView.snp.makeConstraints {
            $0.top.equalTo(weekLabel.snp.bottom).offset(10)
            $0.leading.equalTo(safeArea).offset(30)
            $0.trailing.equalTo(safeArea).offset(-30)
        }
        
        selectColorLabel.snp.makeConstraints {
            $0.top.equalTo(dayHorizontalStackView.snp.bottom).offset(55)
            $0.leading.equalTo(safeArea).offset(47)
            $0.trailing.equalTo(safeArea).offset(-47)
        }
        
        purpleButton.snp.makeConstraints {
            $0.height.equalTo(130)
        }
        
        colorHorizontalStackView.snp.makeConstraints {
            $0.top.equalTo(selectColorLabel.snp.bottom).offset(10)
            $0.leading.equalTo(safeArea).offset(30)
            $0.trailing.equalTo(safeArea).offset(-30)
        }
        
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(colorHorizontalStackView.snp.bottom).offset(95)
            $0.leading.equalTo(safeArea).offset(50)
            $0.trailing.equalTo(safeArea).offset(-50)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(warningLabel.snp.bottom).offset(16)
            $0.leading.equalTo(safeArea).offset(15)
            $0.trailing.equalTo(safeArea).offset(-16)
            $0.height.equalTo(50)
        }
    }
}
