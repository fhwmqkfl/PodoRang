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
    let datePicker = UIDatePicker()
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
    
    var diaryDate: Date?
    
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
        
        setLabel(goalLabel, text: "목표")
        
        goalTextField.layer.borderWidth = 1
        goalTextField.layer.borderColor = CustomColor.mainPurpleColor.cgColor
        goalTextField.layer.cornerRadius = 10
        
        setLabel(startDayLabel, text: "시작하는 날을 선택해 주세요")
        
        startDayTextField.tintColor = .clear
        startDayTextField.layer.borderWidth = 1
        startDayTextField.layer.borderColor = UIColor.blue.cgColor
        startDayTextField.textColor = .black
        startDayTextField.textAlignment = .center
        
        setupDatePicker()
        startDayTextField.inputView = datePicker
        
        setLabel(selectColorLabel, text: "포도알 갯수")
        
        setButton(oneWeekButton, title: "7일")
        setButton(twoWeeksButton, title: "14일")
        setButton(threeWeeksButton, title: "21일")
        
        setHorizontalStackView(dayHorizontalStackView)
        
        setLabel(selectColorLabel, text: "포도 종류")
        
        setButtonImage(purpleButton)
        setButtonImage(redButton)
        setButtonImage(greenButton)
        
        purpleButton.addTarget(self, action: #selector(purpleButtonClicked), for: .touchUpInside)
        redButton.addTarget(self, action: #selector(redButtonClicked), for: .touchUpInside)
        greenButton.addTarget(self, action: #selector(greenButtonClicked), for: .touchUpInside)

        setHorizontalStackView(colorHorizontalStackView)
        
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
    
    @objc func purpleButtonClicked() {
        if redButton.isEnabled == false {
            redButton.isEnabled = true
            greenButton.isEnabled = true
        } else {
            redButton.isEnabled = false
            greenButton.isEnabled = false
        }
    }

    @objc func redButtonClicked() {
        if greenButton.isEnabled == false {
            purpleButton.isEnabled = true
            greenButton.isEnabled = true
        } else {
            purpleButton.isEnabled = false
            greenButton.isEnabled = false
        }
    }
    
    @objc func greenButtonClicked() {
        if purpleButton.isEnabled == false {
            redButton.isEnabled = true
            purpleButton.isEnabled = true
        } else {
            redButton.isEnabled = false
            purpleButton.isEnabled = false
        }
    }

    func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        startDayTextField.inputAccessoryView = toolBar
    }
    
    @objc func dateChange(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        formatter.locale = Locale(identifier: "ko_KR")
        diaryDate = datePicker.date
        startDayTextField.text = formatter.string(from: datePicker.date)
    }
    
    @objc func donePressed() {
        startDayTextField.resignFirstResponder()
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
    
    func setLabel(_ label: UILabel, text: String) {
        label.text = text
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = CustomColor.textPurpleColor
    }
    
    func setButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.layer.borderColor = CustomColor.mainPurpleColor.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 13
    }
    
    func setHorizontalStackView(_ stackView: UIStackView) {
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.distribution = .fillEqually
    }
    
    func setButtonImage(_ button: UIButton) {
        button.setImage(UIImage(named: "grape"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.setImage(UIImage(named: "grayGrape"), for: .disabled)
    }
}

