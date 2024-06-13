import UIKit

class ProfileViewController: UIViewController {

    // Mock user data
    let userData: [String: String] = [
        "name": "Hami",
        "surname": "Karsl,",
        "email": "hami@gmail.com",
        "phone": "+5355555"
    ]
    
    // Define the box view
    let boxView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Define labels for user information
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let surnameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Add the box view to the view
        view.addSubview(boxView)
        
        // Add labels to the box view
        boxView.addSubview(nameLabel)
        boxView.addSubview(surnameLabel)
        boxView.addSubview(emailLabel)
        boxView.addSubview(phoneLabel)

        view.addSubview(logOutButton)
        logOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
        // Setup constraints for the box view
        NSLayoutConstraint.activate([
            boxView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            boxView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            boxView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            boxView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            boxView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // Setup constraints for the labels
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: boxView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -20),
            
            surnameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            surnameLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 20),
            surnameLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -20),
            
            emailLabel.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -20),
            
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            phoneLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 20),
            phoneLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            logOutButton.topAnchor.constraint(equalTo: boxView.bottomAnchor, constant: 30),
            logOutButton.centerXAnchor.constraint(equalTo: boxView.centerXAnchor)
        ])
        
        // Set the user data to the labels
        nameLabel.text = "Name: \(userData["name"] ?? "")"
        surnameLabel.text = "Surname: \(userData["surname"] ?? "")"
        emailLabel.text = "Email: \(userData["email"] ?? "")"
        phoneLabel.text = "Phone: \(userData["phone"] ?? "")"
    }
    
    @objc func logOutTapped() {
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
