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
    let informationLabel = UILabel()
    let selectColorLabel = UILabel()
    let purpleButton = UIButton()
    let redButton = UIButton()
    let greenButton = UIButton()
    let colorHorizontalStackView = UIStackView()
    let warningLabel = UILabel()
    let saveButton = UIButton()
    let deleteButton = UIButton()
    var newGoal: Goal = Goal(title: "", startDate: Date(), grainCount: .none, grapeType: Grape.none)
    var buttonArray = [UIButton]()
    var grapeTypeArray = [UIButton]()
    var setupType: SetupType = .add
    
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
        backgroundColor = .white
        lineView.backgroundColor = .systemGray5
        
        setLabel(goalLabel, text: "Title")
        setLabel(startDayLabel, text: "Select a start date")
        setInfoLabel(informationLabel, text: "Selected number will be set as the period")
        setInfoLabel(warningLabel, text: "⚠️ Count & StartDate can't be changed!!")
        
        setTextField(goalTextField)
        setTextField(startDayTextField)
        setupDatePicker()
        startDayTextField.inputView = datePicker
        
        setLabel(weekLabel, text: "Count of Grains")
        setButton(oneWeekButton, title: "7", tag: GrainCount.oneWeek.rawValue)
        setButton(twoWeeksButton, title: "14", tag: GrainCount.twoWeeks.rawValue)
        setButton(threeWeeksButton, title: "21", tag: GrainCount.threeWeeks.rawValue)
        buttonArray.append(oneWeekButton)
        buttonArray.append(twoWeeksButton)
        buttonArray.append(threeWeeksButton)
        oneWeekButton.addTarget(self, action: #selector(weekButtonClicked), for: .touchUpInside)
        twoWeeksButton.addTarget(self, action: #selector(weekButtonClicked), for: .touchUpInside)
        threeWeeksButton.addTarget(self, action: #selector(weekButtonClicked), for: .touchUpInside)
        setHorizontalStackView(dayHorizontalStackView)
        
        setLabel(selectColorLabel, text: "Color of Grape")
        setButtonImage(purpleButton, tag: Grape.purple.rawValue)
        setButtonImage(redButton, tag: Grape.red.rawValue)
        setButtonImage(greenButton, tag: Grape.green.rawValue)
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
        saveButton.layer.cornerRadius = 15
        saveButton.backgroundColor = .systemGray2
        
        deleteButton.setTitle("DELETE", for: .normal)
        deleteButton.backgroundColor = CustomColor.buttonRed
        deleteButton.tintColor = .white
        deleteButton.clipsToBounds = true
        deleteButton.layer.cornerRadius = 15
        deleteButton.isHidden = true
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.touch))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        contentScrollView.addGestureRecognizer(recognizer)
    }
    
    func addSubviews() {
        addSubview(contentScrollView)
        contentScrollView.addSubview(contentView)
        contentView.addSubviews([lineView, goalLabel, goalTextField, startDayLabel, weekLabel, startDayTextField, selectColorLabel, dayHorizontalStackView, informationLabel, colorHorizontalStackView, warningLabel, saveButton, deleteButton])
        dayHorizontalStackView.addArragnedSubViews([oneWeekButton, twoWeeksButton, threeWeeksButton])
        colorHorizontalStackView.addArragnedSubViews([purpleButton, greenButton, redButton])
    }
    
    func setupConstraints() {
        let contentViewArea = contentView.safeAreaLayoutGuide
        let spacing: Int = 40
        
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
            $0.leading.equalTo(contentViewArea).offset(spacing)
        }
        
        goalTextField.snp.makeConstraints {
            $0.top.equalTo(goalLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentViewArea).inset(spacing)
        }
        
        startDayLabel.snp.makeConstraints {
            $0.top.equalTo(goalTextField.snp.bottom).offset(40)
            $0.leading.equalTo(contentViewArea).offset(spacing)
        }
        
        startDayTextField.snp.makeConstraints {
            $0.top.equalTo(startDayLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentViewArea).inset(spacing)
        }
        
        weekLabel.snp.makeConstraints {
            $0.top.equalTo(startDayTextField.snp.bottom).offset(40)
            $0.leading.trailing.equalTo(contentViewArea).inset(spacing)
        }
        
        dayHorizontalStackView.snp.makeConstraints {
            $0.top.equalTo(weekLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentViewArea).inset(30)
        }
        
        informationLabel.snp.makeConstraints {
            $0.top.equalTo(dayHorizontalStackView.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentViewArea).inset(spacing)
        }
        
        selectColorLabel.snp.makeConstraints {
            $0.top.equalTo(informationLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(contentViewArea).inset(spacing)
        }
        
        purpleButton.snp.makeConstraints {
            $0.height.equalTo(purpleButton.snp.width).multipliedBy(1.3)
        }
        
        colorHorizontalStackView.snp.makeConstraints {
            $0.top.equalTo(selectColorLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentViewArea).inset(spacing)
        }
        
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(colorHorizontalStackView.snp.bottom).offset(90)
            $0.leading.trailing.equalTo(contentViewArea).inset(spacing)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(warningLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(contentViewArea).inset(25)
            $0.height.equalTo(50)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(saveButton.snp.bottom).offset(15)
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
    
    func setInfoLabel(_ label: UILabel, text: String) {
        label.text = text
        label.textColor = CustomColor.infoGreen
        label.font = .boldSystemFont(ofSize: 13)
        label.textAlignment = .center
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
        if tag == Grape.purple.rawValue {
            button.setImage(UIImage(named: "purpleButton"), for: .normal)
        } else if tag == Grape.red.rawValue {
            button.setImage(UIImage(named: "redButton"), for: .normal)
        } else {
            button.setImage(UIImage(named: "greenButton"), for: .normal)
        }
        
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
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
    
    func setSaveButton(isOn: Bool) {
        switch isOn {
        case true:
            saveButton.isEnabled = true
            saveButton.backgroundColor = CustomColor.buttonGreen
        case false:
            saveButton.isEnabled = false
            saveButton.backgroundColor = .systemGray2
        }
    }
    
    func checkValidation() {
        let isTitleExist = !newGoal.title.isEmpty
        let isGrapeTypeExist = newGoal.grapeType != .none
        
        if setupType == .modify {
            if isTitleExist, isGrapeTypeExist {
                setSaveButton(isOn: true)
            } else {
                setSaveButton(isOn: false)
            }
        } else {
            let isStartDateExist = newGoal.startDate.toStringWithoutTime() >= Date().toStringWithoutTime() && !startDayTextField.text!.isEmpty
            let isGrainCountExist = newGoal.grainCount != .none
            
            if isTitleExist, isStartDateExist, isGrainCountExist, isGrapeTypeExist {
                setSaveButton(isOn: true)
            } else {
                setSaveButton(isOn: false)
            }
        }
    }
    
    func setupModifyUI(goal: Goal) {
        warningLabel.snp.updateConstraints {
            $0.top.equalTo(colorHorizontalStackView.snp.bottom).offset(45)
        }
        
        setupType = .modify
        goalTextField.text = goal.title
        startDayTextField.text = goal.startDate.toStringWithoutTime()
        startDayTextField.isUserInteractionEnabled = false
        startDayTextField.textColor = .systemGray2
        newGoal.grapeType = goal.grapeType
        newGoal.title = goal.title
        
        let grainCount = goal.grainCount
        
        if grainCount == GrainCount.oneWeek {
            oneWeekButton.isSelected = true
            oneWeekButton.backgroundColor = CustomColor.lightPurple
        } else if grainCount == GrainCount.twoWeeks {
            twoWeeksButton.isSelected = true
            twoWeeksButton.backgroundColor = CustomColor.lightPurple
        } else {
            threeWeeksButton.isSelected = true
            threeWeeksButton.backgroundColor = CustomColor.lightPurple
        }
        
        oneWeekButton.isEnabled = false
        twoWeeksButton.isEnabled = false
        threeWeeksButton.isEnabled = false
        deleteButton.isHidden = false
        
        let colorButton = grapeTypeArray[goal.grapeType.rawValue]
        
        if colorButton == purpleButton {
            purpleButton.isSelected = true
            redButton.isEnabled = false
            greenButton.isEnabled = false
        } else if colorButton == redButton {
            redButton.isSelected = true
            purpleButton.isEnabled = false
            greenButton.isEnabled = false
        } else {
            greenButton.isSelected = true
            redButton.isEnabled = false
            purpleButton.isEnabled = false
        }
    }
    
    @objc func purpleButtonClicked() {
        if !redButton.isEnabled {
            purpleButton.isSelected = false
            redButton.isEnabled = true
            greenButton.isEnabled = true
            newGoal.grapeType = .none
        } else {
            purpleButton.isSelected = true
            redButton.isEnabled = false
            greenButton.isEnabled = false
            newGoal.grapeType = .purple
        }
        
        checkValidation()
    }
    
    @objc func redButtonClicked() {
        if !greenButton.isEnabled{
            redButton.isSelected = false
            purpleButton.isEnabled = true
            greenButton.isEnabled = true
            newGoal.grapeType = .none
        } else {
            redButton.isSelected = true
            purpleButton.isEnabled = false
            greenButton.isEnabled = false
            newGoal.grapeType = .red
        }
        
        checkValidation()
    }
    
    @objc func greenButtonClicked() {
        if !purpleButton.isEnabled {
            greenButton.isSelected = false
            redButton.isEnabled = true
            purpleButton.isEnabled = true
            newGoal.grapeType = .none
        } else {
            greenButton.isSelected = true
            redButton.isEnabled = false
            purpleButton.isEnabled = false
            newGoal.grapeType = .green
        }
        
        checkValidation()
    }
    
    @objc func dateChange(_ datePicker: UIDatePicker) {
        startDayTextField.text = datePicker.date.toStringWithoutTime()
        newGoal.startDate = datePicker.date
        checkValidation()
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
                newGoal.grainCount = GrainCount.allCases.filter { $0.rawValue == button.tag }.first ?? .none
            } else {
                button.isSelected = false
                button.backgroundColor = .white
            }
        }
        
        checkValidation()
    }
}
