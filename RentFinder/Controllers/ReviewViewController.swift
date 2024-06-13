import UIKit

protocol ReviewViewControllerDelegate: AnyObject {
    func didSubmitReview(for reservation: Reservation, reviewText: String, rating: Int)
}

class ReviewViewController: UIViewController {
    
    var reservation: Reservation!
    weak var delegate: ReviewViewControllerDelegate?
    
    private let reviewTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your review..."
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "Rating: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Review Reservation"
        
        setupUI()
    }
    
    private func setupUI() {
        // Review text field
        view.addSubview(reviewTextField)
        NSLayoutConstraint.activate([
            reviewTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            reviewTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            reviewTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            reviewTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Rating label
        view.addSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: reviewTextField.bottomAnchor, constant: 20),
            ratingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        // Rating stars (assumed to be 5 stars)
        for i in 1...5 {
            let starButton = UIButton(type: .system)
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
            starButton.tag = i // Store the rating value in tag
            starButton.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
            starButton.translatesAutoresizingMaskIntoConstraints = false
            ratingStackView.addArrangedSubview(starButton)
            NSLayoutConstraint.activate([
                starButton.widthAnchor.constraint(equalToConstant: 40),
                starButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
        view.addSubview(ratingStackView)
        NSLayoutConstraint.activate([
            ratingStackView.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 10),
            ratingStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        // Submit button
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(submitReview), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 40)
        ])
    }
    
    @objc private func starButtonTapped(_ sender: UIButton) {
        // Handle star rating selection
        let rating = sender.tag
        updateStarButtons(with: rating)
    }
    
    private func updateStarButtons(with rating: Int) {
        for case let starButton as UIButton in ratingStackView.arrangedSubviews {
            let isSelected = starButton.tag <= rating
            starButton.setImage(isSelected ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
        }
    }
    
    @objc private func submitReview() {
        // Validate input
        guard let reviewText = reviewTextField.text, !reviewText.isEmpty else {
            showAlert(message: "Please enter a review.")
            return
        }
        
        guard let rating = getSelectedRating() else {
            showAlert(message: "Please select a rating.")
            return
        }
        
        let reviewRequest = ReviewRequest(description: reviewText, userScore: rating)
        
        // Call API to submit review
        APICaller.shared.submitReview(for: reservation.propertyID, reservationID: reservation.reservationID, reviewRequest: reviewRequest) { [weak self] result in
            switch result {
            case .success(let response):
                print("Review submitted successfully: \(response)")
                DispatchQueue.main.async {
                    // Show success alert
                    let alert = UIAlertController(title: "Review Submitted", message: "Fake Result: \(response.fakeResult)\nSentiment Result: \(response.sentimentResult)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        // Pop view controller
                        self?.navigationController?.popViewController(animated: true)
                    }))
                    self?.present(alert, animated: true, completion: nil)
                }
            case .failure(let error):
                print("Failed to submit review: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.showAlert(message: "Failed to submit review. Please try again.")
                }
            }
        }
        
        // Notify delegate with review and rating
//        delegate?.didSubmitReview(for: reservation, reviewText: reviewText, rating: rating)
        
        // Dismiss view controller
//        navigationController?.popViewController(animated: true)
    }
    
    private func getSelectedRating() -> Int? {
        // Find the selected star rating
        for case let starButton as UIButton in ratingStackView.arrangedSubviews {
            if starButton.currentImage == UIImage(systemName: "star.fill") {
                return starButton.tag
            }
        }
        return nil
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
