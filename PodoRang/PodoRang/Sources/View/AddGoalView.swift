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
    let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    let contentView = UIView()
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
    let alartLabel: UILabel = {
        let label = UILabel()
        label.textColor = CustomColor.warningRed
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
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
    var grapeTypeArray = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        goalTextField.delegate = self
        
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
        setLabel(startDayLabel, text: "시작하는 날을 선택해 주세요")
        
        setTextField(goalTextField)
        setTextField(startDayTextField)
        setupDatePicker()
        startDayTextField.inputView = datePicker
        
        setLabel(weekLabel, text: "포도알 갯수")
        setButton(oneWeekButton, title: "7일", tag: 7)
        setButton(twoWeeksButton, title: "14일", tag: 14)
        setButton(threeWeeksButton, title: "21일", tag: 21)
        buttonArray.append(oneWeekButton)
        buttonArray.append(twoWeeksButton)
        buttonArray.append(threeWeeksButton)
        oneWeekButton.addTarget(self, action: #selector(weekButtonClicked), for: .touchUpInside)
        twoWeeksButton.addTarget(self, action: #selector(weekButtonClicked), for: .touchUpInside)
        threeWeeksButton.addTarget(self, action: #selector(weekButtonClicked), for: .touchUpInside)
        setHorizontalStackView(dayHorizontalStackView)
        
        setLabel(selectColorLabel, text: "포도 종류")
        setButtonImage(purpleButton, tag: 0)
        setButtonImage(redButton, tag: 1)
        setButtonImage(greenButton, tag: 2)
        grapeTypeArray.append(purpleButton)
        grapeTypeArray.append(redButton)
        grapeTypeArray.append(greenButton)
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
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.touch))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        contentScrollView.addGestureRecognizer(recognizer)
    }
    
    func addSubviews() {
        addSubview(contentScrollView)
        contentScrollView.addSubview(contentView)
        contentView.addSubviews([lineView, goalLabel, goalTextField, startDayLabel, weekLabel, startDayTextField, selectColorLabel, dayHorizontalStackView, alartLabel, colorHorizontalStackView, warningLabel, saveButton])
        dayHorizontalStackView.addArragnedSubViews([oneWeekButton, twoWeeksButton, threeWeeksButton])
        colorHorizontalStackView.addArragnedSubViews([purpleButton, redButton, greenButton])
    }
    
    func setupConstraints() {
        let contentViewArea = contentView.safeAreaLayoutGuide
        let layout = 40
        
        contentScrollView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(contentScrollView.contentLayoutGuide)
            $0.width.equalTo(contentScrollView.frameLayoutGuide)
        }
        
        lineView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentViewArea)
            $0.height.equalTo(1)
        }
        
        goalLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(lineView.snp.bottom).offset(40)
            $0.leading.equalTo(contentViewArea).offset(layout)
        }
        
        goalTextField.snp.makeConstraints {
            $0.top.equalTo(goalLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentViewArea).inset(layout)
        }
        
        startDayLabel.snp.makeConstraints {
            $0.top.equalTo(goalTextField.snp.bottom).offset(40)
            $0.leading.equalTo(contentViewArea).offset(layout)
        }
        
        startDayTextField.snp.makeConstraints {
            $0.top.equalTo(startDayLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentViewArea).inset(layout)
        }
        
        weekLabel.snp.makeConstraints {
            $0.top.equalTo(startDayTextField.snp.bottom).offset(40)
            $0.leading.trailing.equalTo(contentViewArea).inset(layout)
        }
        
        dayHorizontalStackView.snp.makeConstraints {
            $0.top.equalTo(weekLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentViewArea).inset(30)
        }
        
        alartLabel.snp.makeConstraints {
            $0.top.equalTo(dayHorizontalStackView.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(contentViewArea).inset(layout)
        }
        
        selectColorLabel.snp.makeConstraints {
            $0.top.equalTo(alartLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(contentViewArea).inset(layout)
        }
        
        purpleButton.snp.makeConstraints {
            $0.height.equalTo(purpleButton.snp.width).multipliedBy(1.3)
        }
        
        colorHorizontalStackView.snp.makeConstraints {
            $0.top.equalTo(selectColorLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentViewArea).inset(layout)
        }
        
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(colorHorizontalStackView.snp.bottom).offset(90)
            $0.leading.trailing.equalTo(contentViewArea).inset(layout)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(warningLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(contentViewArea).inset(25)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func setLabel(_ label: UILabel, text: String) {
        label.text = text
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = CustomColor.textPurple
    }
    
    func setButton(_ button: UIButton, title: String, tag: Int) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.layer.borderColor = CustomColor.mainPurple.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 13
        button.tag = tag
    }
    
    func setHorizontalStackView(_ stackView: UIStackView) {
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.distribution = .fillEqually
    }
    
    func setButtonImage(_ button: UIButton, tag: Int) {
        button.setImage(UIImage(named: "grape"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.setImage(UIImage(named: "grayGrape"), for: .disabled)
        button.tag = tag
    }
    
    func setTextField(_ textField: IsaoTextField) {
        textField.inactiveColor = CustomColor.lightPurple
        textField.activeColor = CustomColor.mainPurple
        textField.font = .systemFont(ofSize: 16)
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
    
    @objc func touch() {
        self.contentView.endEditing(true)
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

extension AddGoalView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

