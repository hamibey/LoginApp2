import UIKit

class ReservationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ReviewViewControllerDelegate {

    let tableView = UITableView()
    var reservations: [Reservation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Reservations"
        
        // Setup TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ReservationCellView.self, forCellReuseIdentifier: "ReservationCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        APICaller.shared.getUserReservations { [weak self] result in
            switch result {
            case .success(let model):
                self?.reservations = model
                print("ok")
                print(model)
            case .failure(let error):
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell", for: indexPath) as! ReservationCellView
        let reservation = reservations[indexPath.row]
        cell.configure(with: reservation)
        return cell
    }
    
    // Handle cell selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reservation = reservations[indexPath.row]
        showReviewScreen(for: reservation)
        
        // Deselect the cell to remove the selection highlight
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func showReviewScreen(for reservation: Reservation) {
        // Present ReviewViewController for review entry
        let reviewVC = ReviewViewController()
        reviewVC.reservation = reservation
        reviewVC.delegate = self
        let navController = UINavigationController(rootViewController: reviewVC)
        present(navController, animated: true, completion: nil)
    }
    
    // ReviewViewControllerDelegate method
    func didSubmitReview(for reservation: Reservation, reviewText: String, rating: Int) {
        // Handle review submission (e.g., send to backend API)
        print("Submitted review for reservation ID \(reservation.reservationID):")
        print("Review: \(reviewText)")
        print("Rating: \(rating)")
        
        // Update UI or perform any necessary actions after review submission
    }
}
