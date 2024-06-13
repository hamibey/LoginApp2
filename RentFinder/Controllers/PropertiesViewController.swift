import UIKit

class PropertiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    var properties: [Property] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Properties"
        
        // Setup TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PropertyCellView.self, forCellReuseIdentifier: "PropertyCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Load mock data
        loadMockData()
    }
    
    func loadMockData() {
        properties = [
            Property(id: "1", address: "123 Main St", description: "Beautiful 2-bedroom apartment", flatNo: "10A", placeOffers: "Gym, Pool", price: "$1000/month", propertyType: "Apartment"),
            Property(id: "2", address: "456 Elm St", description: "Spacious 3-bedroom house", flatNo: "N/A", placeOffers: "Garden, Garage", price: "$2000/month", propertyType: "House"),
            Property(id: "3", address: "789 Oak St", description: "Modern studio", flatNo: "5B", placeOffers: "Wi-Fi, Laundry", price: "$800/month", propertyType: "Studio")
        ]
        tableView.reloadData()
    }
    
    // TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyCell", for: indexPath) as! PropertyCellView
        let property = properties[indexPath.row]
        cell.configure(with: property)
        return cell
    }
}
