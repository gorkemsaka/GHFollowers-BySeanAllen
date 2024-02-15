//
//  GFAlertViewController.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 31.01.2024.
//

import UIKit

class GFAlertViewController: UIViewController {
    //MARK: - UI Elements
    let containerView = UIView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let bodyLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(backgroundColor: .systemPink, title: nil)
    
    //MARK: - Properties
    var alertTitle: String?
    var bodyTitle: String?
    var buttonTitle: String?
    
    //MARK: - Lifecycle
    init(alertTitle: String, bodyTitle: String, buttonTitle: String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.bodyTitle = bodyTitle
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // thats givin %75 opacity of the background
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureConteinerView()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()
    }
}

//MARK: - Configure UI Elements
extension GFAlertViewController {
    private func configureConteinerView(){
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
   private func configureTitleLabel(){
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureActionButton(){
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? Theme.AppTitle.alertButtonTitle.rawValue, for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureBodyLabel(){
        containerView.addSubview(bodyLabel)
        bodyLabel.text = bodyTitle ?? "Unable to complete request"
        bodyLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            bodyLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -20)
        ])
    }
}

//MARK: - Button Dismiss action
extension GFAlertViewController {
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}
