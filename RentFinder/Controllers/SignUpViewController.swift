import UIKit

class SignUpViewController: UIViewController {

    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let surnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Surname"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
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
    
    let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone Number"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let dateOfBirthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Date of Birth"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Do you have an account? Log In.", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Add subviews to the view
        view.addSubview(nameTextField)
        view.addSubview(surnameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(dateOfBirthTextField)
        view.addSubview(signUpButton)
        view.addSubview(logInButton)
        
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        logInButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        // Setup constraints for text fields and button
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Name TextField
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Surname TextField
            surnameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            surnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            surnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Email TextField
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Password TextField
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Phone Number TextField
            phoneNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneNumberTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Date of Birth TextField
            dateOfBirthTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateOfBirthTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
            dateOfBirthTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateOfBirthTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Sign Up Button
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: dateOfBirthTextField.bottomAnchor, constant: 20),
            
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 20),
        ])
    }
    
    @objc func handleSignUp() {
        guard let name = nameTextField.text, !name.isEmpty,
              let surname = surnameTextField.text, !surname.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty,
              let dateOfBirth = dateOfBirthTextField.text, !dateOfBirth.isEmpty else {
            print("All fields must be filled")
            return
        }
        
        guard let name = nameTextField.text, !name.isEmpty,
              let surname = surnameTextField.text, !surname.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty,
              let dateOfBirth = dateOfBirthTextField.text, !dateOfBirth.isEmpty else {
            print("All fields must be filled")
            return
        }
        
        let userRequest = RegisterRequest(name: name, surname: surname, email: email, password: password, phoneNumber: phoneNumber, dateOfBirth: dateOfBirth)
        
        APICaller.shared.register(with: userRequest) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("success register")
                    // Handle successful registration here (e.g., navigate to login or main screen)
                    self?.loginTapped()
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    @objc func loginTapped() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
