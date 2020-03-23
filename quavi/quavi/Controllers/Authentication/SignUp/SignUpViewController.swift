//
//  SignUpViewController.swift
//  quavi
//
//  Created by Sunni Tang on 2/20/20.
//  Copyright © 2020 Sunni Tang. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    //MARK: - UI Objects
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Email"
        textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password"
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create New Account", for: .normal)
        button.setTitleColor(.black, for: .normal)
        //TODO: Handle initial button color (should indicate disabled)
        button.setTitleColor(.gray, for: .disabled)
        button.addTarget(self, action: #selector(trySignUp), for: .touchUpInside)
        return button
    }()
    
    lazy var signUpStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
        addConstraints()

    }
    
    //MARK: - Objective-C Methods
    @objc func validateFields() {
        guard emailTextField.hasText, passwordTextField.hasText else {
            signUpButton.isEnabled = false
            return
        }
        signUpButton.isEnabled = true
    }
    
    @objc func trySignUp() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showAlert(title: "Error", message: "Please fill out all fields.")
            return
        }
        
        guard email.isValidEmail else {
            showAlert(title: "Error", message: "Please enter a valid email")
            return
        }
        
        guard password.isValidPassword else {
            showAlert(title: "Error", message: "Please enter a valid password. Passwords must have at least 8 characters.")
            return
        }
        
        //TODO: handle creating new user using FirebaseAuth
        createUser(email: email, password: password)

        print("Try sign up success")
    }

    //MARK: - Private Methods
    private func createUser(email: String, password: String) {
        FirebaseAuthService.manager.createNewUser(email: email, password: password) { [weak self] (result) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .failure(let error):
                    self?.showAlert(title: "Error", message: "Couldn't Create User: \(error.localizedDescription)")
                case .success(let user):
                    self?.saveUsers(with: user)
                }
            }
        }
    }
    
    func saveUsers(with user: User) {
        FirestoreService.manager.createAppUser(user: AppUser(from: user)) { [weak self] newResult in
            switch newResult {
            case .failure(let error):
                self?.showAlert(title: "Error", message: "Couldn't Create New App User: \(error.localizedDescription)")
            case .success:
                if let window = self?.uiWindow() {
                    UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromRight, animations: {
                        window.rootViewController = QuaviTabBarController()
                    }, completion: nil)
                }
            }
        }
    }
    
    private func uiWindow() -> UIWindow {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
            else {
                showAlert(title: "Error", message: "Could not switch view controllers")
                return UIWindow()
        }
        return window
    }

}
