import UIKit

class ReservationCellView: UITableViewCell {

    let boxView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let propertyIdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let startDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let endDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let reservationIdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(boxView)
        boxView.addSubview(propertyIdLabel)
        boxView.addSubview(startDateLabel)
        boxView.addSubview(endDateLabel)
        boxView.addSubview(reservationIdLabel)
        
        NSLayoutConstraint.activate([
            boxView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            boxView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            boxView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            boxView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            propertyIdLabel.topAnchor.constraint(equalTo: boxView.topAnchor, constant: 10),
            propertyIdLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 10),
            propertyIdLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -10),
            
            startDateLabel.topAnchor.constraint(equalTo: propertyIdLabel.bottomAnchor, constant: 10),
            startDateLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 10),
            startDateLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -10),
            
            endDateLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: 10),
            endDateLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 10),
            endDateLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -10),
            
            reservationIdLabel.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: 10),
            reservationIdLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 10),
            reservationIdLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -10),
            reservationIdLabel.bottomAnchor.constraint(equalTo: boxView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with reservation: Reservation) {
        propertyIdLabel.text = "Property ID: \(reservation.propertyID)"
        reservationIdLabel.text = "Reservation ID: \(reservation.reservationID)"
        startDateLabel.text = "Start Date: \(reservation.startDate)"
        endDateLabel.text = "End Date: \(reservation.endDate)"
    }
}
