import UIKit

class LoginViewController: UIViewController {

    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't you have an account? Sign up.", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Email and password must not be empty")
            return
        }
        let loginRequest = LoginRequest(email: email, password: password)
        var shouldNavigate = false
        APICaller.shared.login(with: loginRequest) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    // save the token to user defaults
                    UserDefaults.standard.set(response.token, forKey: "authToken")
                    UserDefaults.standard.set("true", forKey: "isLoggedIn")
                    // shouldNavigate = true
                    let mainTabBarVC = TabBarViewController()
                    mainTabBarVC.modalPresentationStyle = .fullScreen
                    self.present(mainTabBarVC, animated: true)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        
//        if shouldNavigate {
//            let mainTabBarVC = TabBarViewController()
//            mainTabBarVC.modalPresentationStyle = .fullScreen
//            present(mainTabBarVC, animated: true)
//        }
    }
    
    @objc func signUpTapped() {
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}

