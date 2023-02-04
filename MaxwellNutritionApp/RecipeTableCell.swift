import Foundation
import UIKit

class RecipeTableCell : UITableViewCell {
    var cardView = UIView()
    var foodNameLabel = UILabel()
    var foodImageView = UIImageView()
    
    let bgColor = UIColor(red: 240.0/255.0, green: 200.0/255.0, blue: 122.0/255.0, alpha: 1)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cardView.backgroundColor = bgColor
        addSubview(cardView)
        cardView.addSubview(foodNameLabel)
        cardView.addSubview(foodImageView)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        foodNameLabel.translatesAutoresizingMaskIntoConstraints = false
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            foodImageView.leadingAnchor.constraint(equalTo: cardView.layoutMarginsGuide.leadingAnchor, constant: 10),
            foodImageView.widthAnchor.constraint(equalToConstant: 75),
            foodImageView.heightAnchor.constraint(equalToConstant: 75),
            foodImageView.centerYAnchor.constraint(equalTo: self.cardView.centerYAnchor),
            
            foodNameLabel.topAnchor.constraint(equalTo: cardView.layoutMarginsGuide.topAnchor),
            foodNameLabel.leadingAnchor.constraint(equalTo: foodImageView.layoutMarginsGuide.trailingAnchor, constant: 20),
            foodNameLabel.trailingAnchor.constraint(equalTo: cardView.layoutMarginsGuide.trailingAnchor),
            foodNameLabel.bottomAnchor.constraint(equalTo: cardView.layoutMarginsGuide.bottomAnchor)
        ])
        foodImageView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
