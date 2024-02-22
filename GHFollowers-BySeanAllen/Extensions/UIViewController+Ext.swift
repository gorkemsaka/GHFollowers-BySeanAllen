//
//  UIViewController+Ext.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 31.01.2024.
//

import UIKit
import SafariServices

// anything in this file can use that variable
fileprivate var containerView: UIView!

extension UIViewController {
    //Alert
    func presentGFAlertOnMainThread(title: String, bodyTitle: String, buttonTitle: String){
        DispatchQueue.main.async {
                    let alertVC = GFAlertViewController(alertTitle: title, bodyTitle: bodyTitle, buttonTitle: buttonTitle)
                    alertVC.modalPresentationStyle = .overFullScreen
                    alertVC.modalTransitionStyle = .crossDissolve
                    self.present(alertVC, animated: true)
                }
    }
    
    // Start Activity Indicator
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        
        containerView.alpha = 0 // transparency goes 0 to 0.8 for good animation
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activtyIndicatior: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activtyIndicatior)
        activtyIndicatior.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activtyIndicatior.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activtyIndicatior.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activtyIndicatior.startAnimating()
    }
    
    // Stop Activiy Indicator
    func dismissLoadingView(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    // Show Empty State View
    func showEmptyStateView(message: String, view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
            emptyStateView.frame = view.bounds
            view.addSubview(emptyStateView)
    }
    
    // Show SafariVC for webviews
    func presentSafariVC(url: URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
