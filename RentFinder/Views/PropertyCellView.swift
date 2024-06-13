import UIKit

class PropertyCellView: UITableViewCell {

    let boxView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let flatNoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let placeOffersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let propertyTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(boxView)
        boxView.addSubview(idLabel)
        boxView.addSubview(addressLabel)
        boxView.addSubview(descriptionLabel)
        boxView.addSubview(flatNoLabel)
        boxView.addSubview(placeOffersLabel)
        boxView.addSubview(priceLabel)
        boxView.addSubview(propertyTypeLabel)
        
        NSLayoutConstraint.activate([
            boxView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            boxView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            boxView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            boxView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            idLabel.topAnchor.constraint(equalTo: boxView.topAnchor, constant: 10),
            idLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 10),
            idLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -10),
            
            addressLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 10),
            addressLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -10),
            
            flatNoLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            flatNoLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 10),
            flatNoLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -10),
            
            placeOffersLabel.topAnchor.constraint(equalTo: flatNoLabel.bottomAnchor, constant: 10),
            placeOffersLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 10),
            placeOffersLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -10),
            
            priceLabel.topAnchor.constraint(equalTo: placeOffersLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -10),
            
            propertyTypeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            propertyTypeLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 10),
            propertyTypeLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -10),
            propertyTypeLabel.bottomAnchor.constraint(equalTo: boxView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with property: Property) {
        idLabel.text = "Property ID: \(property.id)"
        addressLabel.text = "Address: \(property.address)"
        descriptionLabel.text = "Description: \(property.description)"
        flatNoLabel.text = "Flat No: \(property.flatNo)"
        placeOffersLabel.text = "Place Offers: \(property.placeOffers)"
        priceLabel.text = "Price: \(property.price)"
        propertyTypeLabel.text = "Property Type: \(property.propertyType)"
    }
}
