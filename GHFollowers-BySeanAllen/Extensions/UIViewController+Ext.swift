//
//  UIViewController+Ext.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 31.01.2024.
//

import UIKit

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, bodyTitle: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = GFAlertViewController(alertTitle: title, bodyTitle: bodyTitle, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
