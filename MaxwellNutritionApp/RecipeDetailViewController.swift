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
    //contentView.translatesAutoresizingMaskIntoConstraints = false
    stackView.translatesAutoresizingMaskIntoConstraints = false


    view.addSubview(scrollView)

    scrollView.addSubview(stackView)



    scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

    scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

    scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true



    //contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

    //contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

    //contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true

    //contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        //stackView.alignment = UIStackView.Alignment.left
        stackView.spacing = 8.0

        stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -20).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true
//        contentView.addSubview(stackView)
    }



    func setupViews(){

    //contentView.addSubview(label1)

    //label1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

    //label1.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true

    //label1.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true



    //contentView.addSubview(label2)

    //label2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

//    label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 25).isActive = true

    //label2.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true

    //label2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

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
                

//        contentView.addSubview(headerLabel)
//        headerLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        headerLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
//
//        contentView.addSubview(nameLabel)
//        nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        nameLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 25).isActive = true
//        nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
//
//        contentView.addSubview(descriptionLabel)
//        descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 25).isActive = true
//        descriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
//
//        contentView.addSubview(ingredientsLabel)
//        ingredientsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        ingredientsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 25).isActive = true
//        ingredientsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
//
//        ingredientsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
//    func setupUI1() {
//        contentView.backgroundColor = bgColor
//        contentView.addSubview(headerLabel)
//        contentView.addSubview(nameLabel)
//        contentView.addSubview(myImageView)
//        contentView.addSubview(descriptionLabel)
//        contentView.addSubview(ingredientsLabel)
//        contentView.addSubview(bookmarkButton)
//        contentView.addSubview(backButton)
//
//        headerLabel.translatesAutoresizingMaskIntoConstraints = false
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        myImageView.translatesAutoresizingMaskIntoConstraints = false
//        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
//        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
//        backButton.translatesAutoresizingMaskIntoConstraints = false
//
//        descriptionLabel.numberOfLines = 3
//        ingredientsLabel.numberOfLines = 3
//
//        let backimage = UIImage(named: "BackButton")
//        backButton.setImage(backimage, for: .normal)
//        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
//
//        bookmarkButton.backgroundColor = .systemRed
//        if (food.isBookmark) {
//            bookmarkButtonText = "Remove from Favorites"
//        }
//        else {
//            bookmarkButtonText = "Add to Favorites"
//        }
//        bookmarkButton.setTitle(bookmarkButtonText, for: .normal)
//        bookmarkButton.addTarget(self, action: #selector(bookmarksButtonClicked), for: .touchUpInside)
//
//        headerLabel.text = "Details"
//        headerLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
//        headerLabel.textColor = UIColor.red
//        headerLabel.textAlignment = .center
//        nameLabel.text = "Name: " + food.name
//        descriptionLabel.text = "Nutritional Value: \n" + food.description
//        ingredientsLabel.text = "Ingredients: \n" + food.ingredients
//        myImageView.load(urlString: food.imageurl)
//
//        NSLayoutConstraint.activate([
//            backButton.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 30),
//            backButton.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
//
//            headerLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 50),
//            headerLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 10),
//            headerLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -10),
//
//            nameLabel.topAnchor.constraint(equalTo: headerLabel.layoutMarginsGuide.topAnchor, constant: 60),
//            nameLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 10),
//            nameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -10),
//
////            myImageView.topAnchor.constraint(equalTo: nameLabel.layoutMarginsGuide.topAnchor, constant: 60),
////            myImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
////            myImageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
//
//
//            myImageView.topAnchor.constraint(equalTo: nameLabel.layoutMarginsGuide.topAnchor, constant: 60),
//            myImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor), myImageView.widthAnchor.constraint(equalToConstant: 300), myImageView.heightAnchor.constraint(equalToConstant: 300),
//
//
//            descriptionLabel.topAnchor.constraint(equalTo: myImageView.layoutMarginsGuide.bottomAnchor, constant: 20),
//            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 10),
//            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -10),
//
//            ingredientsLabel.topAnchor.constraint(equalTo: descriptionLabel.layoutMarginsGuide.bottomAnchor, constant: 20),
//            ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 10),
//            ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -10),
//
//            bookmarkButton.topAnchor.constraint(equalTo: ingredientsLabel.layoutMarginsGuide.bottomAnchor, constant: 30),
//            bookmarkButton.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 10),
//            bookmarkButton.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -10)
//        ])
//    }
    

    
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
