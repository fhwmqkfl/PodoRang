//
//  AddGoalView.swift
//  PodoRang
//
//  Created by coco on 2023/06/05.
//

import UIKit
import SnapKit
import TextFieldEffects

class AddGoalView: UIView {
    let lineView = UIView()
    let goalLabel = UILabel()
    let goalTextField = IsaoTextField()
    let startDayLabel = UILabel()
    let startDayTextField = IsaoTextField()
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
    let warningLabel: UILabel = {
        let label = UILabel()
        label.text = "포도알 갯수와 포도 종류는 설정하면 변경할 수 없어요!"
        label.textColor = CustomColor.warningRed
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    let saveButton = UIButton()
    
    var diaryDate: Date?
    var buttonArray = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    func setupUI() {
        lineView.backgroundColor = .systemGray5
        
        setLabel(goalLabel, text: "목표")
        setLabel(startDayLabel, text: "시작하는 날을 선택해 주세요")
        
        setTextField(goalTextField)
        setTextField(startDayTextField)
        setupDatePicker()
        startDayTextField.inputView = datePicker
        
        setLabel(weekLabel, text: "포도알 갯수")
        setButton(oneWeekButton, title: "7일")
        setButton(twoWeeksButton, title: "14일")
        setButton(threeWeeksButton, title: "21일")
        buttonArray.append(oneWeekButton)
        buttonArray.append(twoWeeksButton)
        buttonArray.append(threeWeeksButton)
        oneWeekButton.addTarget(self, action: #selector(weekButtonClicked), for: .touchUpInside)
        twoWeeksButton.addTarget(self, action: #selector(weekButtonClicked), for: .touchUpInside)
        threeWeeksButton.addTarget(self, action: #selector(weekButtonClicked), for: .touchUpInside)
        setHorizontalStackView(dayHorizontalStackView)
        
        setLabel(selectColorLabel, text: "포도 종류")
        setButtonImage(purpleButton)
        setButtonImage(redButton)
        setButtonImage(greenButton)
        purpleButton.addTarget(self, action: #selector(purpleButtonClicked), for: .touchUpInside)
        redButton.addTarget(self, action: #selector(redButtonClicked), for: .touchUpInside)
        greenButton.addTarget(self, action: #selector(greenButtonClicked), for: .touchUpInside)
        setHorizontalStackView(colorHorizontalStackView)
        
        saveButton.setTitle("SAVE", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = CustomColor.mainPurple
        saveButton.layer.borderColor = CustomColor.mainPurple.cgColor
        saveButton.layer.borderWidth = 1
        saveButton.layer.cornerRadius = 15
    }
    
    func addSubviews() {
        self.addSubviews([lineView, goalLabel, goalTextField, startDayLabel, weekLabel, startDayTextField, selectColorLabel, dayHorizontalStackView, colorHorizontalStackView, warningLabel, saveButton])
        dayHorizontalStackView.addArragnedSubViews([oneWeekButton, twoWeeksButton, threeWeeksButton])
        colorHorizontalStackView.addArragnedSubViews([purpleButton, redButton, greenButton])
    }
    
    func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        let layout = 47
        
        lineView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeArea)
            $0.height.equalTo(1)
        }
        
        goalLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(lineView.snp.bottom).offset(40)
            $0.leading.equalTo(safeArea).offset(layout)
            $0.trailing.greaterThanOrEqualTo(safeArea).offset(-120)
        }
        
        goalTextField.snp.makeConstraints {
            $0.top.equalTo(goalLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(safeArea).inset(layout)
        }
        
        startDayLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(goalTextField.snp.bottom).offset(40)
            $0.leading.equalTo(safeArea).offset(layout)
            $0.trailing.greaterThanOrEqualTo(safeArea).offset(-120)
        }
        
        startDayTextField.snp.makeConstraints {
            $0.top.equalTo(startDayLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(safeArea).inset(layout)
        }
        
        weekLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(startDayTextField.snp.bottom).offset(40)
            $0.leading.trailing.equalTo(safeArea).inset(layout)
        }
        
        dayHorizontalStackView.snp.makeConstraints {
            $0.top.equalTo(weekLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(safeArea).inset(30)
        }
        
        selectColorLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(dayHorizontalStackView.snp.bottom).offset(40)
            $0.leading.trailing.equalTo(safeArea).inset(layout)
        }
        
        purpleButton.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(130)
        }
        
        colorHorizontalStackView.snp.makeConstraints {
            $0.top.equalTo(selectColorLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(safeArea).inset(30)
        }
        
        warningLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeArea).inset(50)
            $0.bottom.equalTo(saveButton.snp.top).offset(-15)
        }
        
        saveButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeArea).inset(15)
            $0.height.equalTo(50)
            $0.bottom.greaterThanOrEqualTo(safeArea).offset(-40)
        }
    }
    
    func setLabel(_ label: UILabel, text: String) {
        label.text = text
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = CustomColor.textPurple
    }
    
    func setButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.layer.borderColor = CustomColor.mainPurple.cgColor
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
    
    func setTextField(_ textField: IsaoTextField) {
        textField.inactiveColor = CustomColor.lightPurple
        textField.activeColor = CustomColor.mainPurple
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
    
    @objc func purpleButtonClicked() {
        if redButton.isEnabled == false {
            purpleButton.isSelected = false
            redButton.isEnabled = true
            greenButton.isEnabled = true
        } else {
            purpleButton.isSelected = true
            redButton.isEnabled = false
            greenButton.isEnabled = false
        }
    }

    @objc func redButtonClicked() {
        if greenButton.isEnabled == false {
            redButton.isSelected = false
            purpleButton.isEnabled = true
            greenButton.isEnabled = true
        } else {
            redButton.isSelected = true
            purpleButton.isEnabled = false
            greenButton.isEnabled = false
        }
    }
    
    @objc func greenButtonClicked() {
        if purpleButton.isEnabled == false {
            greenButton.isSelected = false
            redButton.isEnabled = true
            purpleButton.isEnabled = true
        } else {
            greenButton.isSelected = true
            redButton.isEnabled = false
            purpleButton.isEnabled = false
        }
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
    
    @objc func weekButtonClicked(_ sender: UIButton) {
        for button in buttonArray {
            if button == sender {
                button.isSelected = true
                button.backgroundColor = CustomColor.lightPurple
            } else {
                button.isSelected = false
                button.backgroundColor = .white
            }
        }
    }
}
