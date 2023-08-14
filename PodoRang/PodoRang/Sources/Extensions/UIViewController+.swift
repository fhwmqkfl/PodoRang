//
//  UIViewController+.swift
//  PodoRang
//
//  Created by coco on 2023/07/18.
//


import UIKit

extension UIViewController {
    func loadImage(data: Data) -> UIImage? {
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        let image = UIImage(data: decoded)
        return image
    }
    
    /// present customized alert
    func presentChoiceAlert(title: String, message: String, buttonTitle: String, preferredStyle: UIAlertController.Style = .alert , completion: @escaping () -> Void) {
        let text: String = title.localized()
        let attributeString = NSMutableAttributedString(string: text)
        let font = UIFont.boldSystemFont(ofSize: 18)
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: text))
        attributeString.addAttribute(.foregroundColor, value: CustomColor.textGreen, range: (text as NSString).range(of: text))
        
        let alertController = UIAlertController(title: text, message: message.localized(), preferredStyle: preferredStyle)
        alertController.setValue(attributeString, forKey: "attributedTitle")
        let addDate = UIAlertAction(title: buttonTitle.localized(), style: .default) { _ in completion() }
        let cancel = UIAlertAction(title: "Cancel".localized(), style: .destructive)
        alertController.addAction(addDate)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    
    func presentAlert(message: String) {
        let alertController = UIAlertController(title: "", message: message.localized(), preferredStyle: UIAlertController.Style.alert)
        let checked = UIAlertAction(title: "OK".localized(), style: .default)
        alertController.addAction(checked)
        present(alertController, animated: true)
    }
}
