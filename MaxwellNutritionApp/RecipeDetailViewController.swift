import Foundation
import UIKit

class RecipeDetailViewController : UIViewController {
    let scrollView = UIScrollView()

    //let contentView = UIView()
    let stackView = UIStackView()
    
    var delegate: addRemoveFromBookmarksDelegate?
    let bgColor = UIColor(red: 240.0/255.0, green: 200.0/255.0, blue: 122.0/255.0, alpha: 1)
    var food = Food(category: 0, name: "", description: "", ingredients: "", isBookmark: false, imageurl: "https://toppng.com/uploads/preview/clipart-free-seaweed-clipart-draw-food-placeholder-11562968708qhzooxrjly.png")
    var headerLabel = UILabel()
    var nameLabel = UILabel()
    var descriptionLabel = UILabel()
    var ingredientsLabel = UILabel()
    var bookmarkButton = UIButton()
    var backButton = UIButton()
    var myImageView = UIImageView()
   
    var bookmarkButtonText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
//        setupViews()
       
        setupUI()
        
    }
    
    func setupScrollView(){

    scrollView.translatesAutoresizingMaskIntoConstraints = false
    
    stackView.translatesAutoresizingMaskIntoConstraints = false


    view.addSubview(scrollView)

    scrollView.addSubview(stackView)



    scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

    scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

    scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true



    

        
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        
        stackView.spacing = 8.0

        stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -20).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true

    }



    func setupViews(){

    

    }

    
    @objc func bookmarksButtonClicked(_sender: UIButton) {
        if (food.isBookmark) {
            food.isBookmark = false
            delegate?.removeFromBookmarks(food: food)
            dismiss(animated: true)
        }
        else {
            food.isBookmark = true
            delegate?.addtoBookmarks(food: food)
            dismiss(animated: false)
        }
    }
    @objc func backButtonClicked(_sender: UIButton) {
        dismiss(animated: true)
    }
    
    func setupUI() {
        scrollView.backgroundColor = bgColor;
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerLabel.text = "Details" //food details
        headerLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        headerLabel.textColor = UIColor.red
        headerLabel.textAlignment = .center
        headerLabel.sizeToFit()
        
        nameLabel.text = "Name: " + food.name //food name
        nameLabel.textColor = UIColor.white
        nameLabel.sizeToFit()
        
        descriptionLabel.text = "Nutritional Value: \n" + food.description
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.numberOfLines = 3
              
        descriptionLabel.sizeToFit()
        
        ingredientsLabel.text = "Ingredients: \n" + food.ingredients
        ingredientsLabel.textColor = UIColor.white
        ingredientsLabel.numberOfLines = 3
        ingredientsLabel.sizeToFit()
        
        myImageView.load(urlString: food.imageurl)
    
        myImageView.contentMode = .scaleAspectFit
        
        
        stackView.addArrangedSubview(backButton)
        stackView.addArrangedSubview(headerLabel)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(myImageView)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(ingredientsLabel)
        stackView.addArrangedSubview(bookmarkButton)
        
        let backimage = UIImage(named: "BackButton")
                backButton.setImage(backimage, for: .normal)
                backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
                
                bookmarkButton.backgroundColor = .systemRed
                if (food.isBookmark) {
                    bookmarkButtonText = "Remove from Favorites"
                }
                else {
                    bookmarkButtonText = "Add to Favorites"
                }
                bookmarkButton.setTitle(bookmarkButtonText, for: .normal)
                bookmarkButton.addTarget(self, action: #selector(bookmarksButtonClicked), for: .touchUpInside)
                

    }
    

    
}

extension UIImageView{ //geting image from url
    func load(urlString: String){
        guard let url = URL(string: urlString) else{
            return
        }
        DispatchQueue.global().async {[weak self] in
            if let data = try?Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
