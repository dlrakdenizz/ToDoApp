//
//  ViewController.swift
//  ToDoApp
//
//  Created by Dilara Akdeniz on 29.04.2025.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - Properties
    private var viewModel = LoginViewModel()
    
    private let logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "checkmark.diamond")
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var emailContainerView: UIView = { //Burayı lazy var yaparak aşağıdaki emailTextField property'si burada kullanılabilir oldu. Çünkü emailTextField dışarıdan bize verilecek, yani kod buraya geldiğinde henüz bu kısım yok, lazy var diyerek sen bu property oluştuğu zaman burada yer aç demiş olduk.
        let emailContainerView = AuthenticationInputView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
        return emailContainerView
    }()
    
    private lazy var passwordContainerView: UIView = {
        let passwordContainerView = AuthenticationInputView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
        return passwordContainerView
    }()
    
    private let emailTextField : UITextField = {
        let textField = CustomTextField(placeHolder: "Email")
        return textField
    }()
    
    private let passwordTextField : UITextField = {
        let textField = CustomTextField(placeHolder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.layer.cornerRadius = 7
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
        
    }()
    
    private var stackView = UIStackView()
    
    private lazy var switchToRegistrationPage : UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Click To Become A Member", attributes: [.foregroundColor : UIColor.white, .font : UIFont.boldSystemFont(ofSize: 14)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleGoRegister), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
    }
}

// MARK: - Selector
extension LoginViewController {
    
    @objc private func handleLoginButton(_ sender : UIButton) {
        guard let emailText = emailTextField.text else {return}
        guard let passwordText = passwordTextField.text else {return}
        showHud(show: true)
        AuthenticationService.login(emailText: emailText, passwordText: passwordText) { result, error in
            if let error = error {
                self.showHud(show: false)
                print("Error : \(error.localizedDescription)")
                return
            }
            self.showHud(show: false)
            self.dismiss(animated: true)
        }
        
    }
    
    @objc private func handleGoRegister(_ sender: UIButton) {
        let controller = RegisterViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @objc private func handleTextField(_ sender: UITextField){
        if sender == emailTextField {
            viewModel.emailText = sender.text
        } else {
            viewModel.passwordText = sender.text
        }
        
        loginbuttonStatus()
    }
}

// MARK: - Helpers
extension LoginViewController {
    private func loginbuttonStatus() {
        if viewModel.status {
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    
    private func style() {
        backgroundGradientColor()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false //Burada düzenlemesinin otomatik olarak yapılmasını kaldırıyoruz çünkü biz yapacağız.
        logoImageView.layer.cornerRadius = 150/2 //Bu kısım dikdörtgen olarak oluşan logoImageView'ı daireye çevirir
        stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        switchToRegistrationPage.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
    }
    
    private func layout() {
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        view.addSubview(switchToRegistrationPage)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            view.trailingAnchor.constraint(equalTo: emailContainerView.trailingAnchor, constant: 32),
            
            switchToRegistrationPage.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            switchToRegistrationPage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            view.trailingAnchor.constraint(equalTo: switchToRegistrationPage.trailingAnchor, constant: 32)
        ])
    }
}
