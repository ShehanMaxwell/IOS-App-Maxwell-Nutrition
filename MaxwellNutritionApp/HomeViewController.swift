import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import MBProgressHUD

protocol addRemoveFromBookmarksDelegate {
    func addtoBookmarks(food: Food)
    func removeFromBookmarks(food: Food)
}

class HomeViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, addRemoveFromBookmarksDelegate {

    let ref = Database.database().reference(withPath: "food-items").child("categories")

    let bgColor = UIColor(red: 240.0/255.0, green: 200.0/255.0, blue: 122.0/255.0, alpha: 1)
    var tableView = UITableView()
    var breakfastCategoryButton = UIButton()
    var lunchCategoryButton = UIButton()
    var dinnerCategoryButton = UIButton()
    var bookmarksButton = UIButton()
    var buttonStack = UIStackView()
    
    var toBeLoadedInTable : [Food] = []
    var breakfast : [Food] = []
    var lunch : [Food] = []
    var dinner : [Food] = []
    var bookmarks : [Food] = []
    var bookmarksDisplaying = false
    var bookmarkIndexOpened = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingUI()
        tableView.delegate = self
        tableView.dataSource = self
        
            
        ref.child("breakfast").observe(.childAdded) { [weak self] snapshot in
            let data = snapshot.value as! [String:Any]
            self?.breakfast.append(Food(category: 0, name: data["name"] as! String, description: data["description"] as! String, ingredients: data["ingredients"] as! String, isBookmark: false, imageurl: data["imageurl"] as! String))
            
            
            self!.setupUI()
            self!.toBeLoadedInTable = self!.breakfast
            self!.tableView.reloadData()
            MBProgressHUD.hide(for: self!.view, animated: true)
        }
        
        ref.child("lunch").observe(.childAdded) { [weak self] snapshot in
            let data = snapshot.value as! [String:Any]
            self?.lunch.append(Food(category: 1, name: data["name"] as! String, description: data["description"] as! String, ingredients: data["ingredients"] as! String, isBookmark: false, imageurl: data["imageurl"] as! String))
        }
        
        ref.child("dinner").observe(.childAdded) { [weak self] snapshot in
            let data = snapshot.value as! [String:Any]
            self?.dinner.append(Food(category: 2, name: data["name"] as! String, description: data["description"] as! String, ingredients: data["ingredients"] as! String, isBookmark: false, imageurl: data["imageurl"] as! String))
        }
    }
    func setupLoadingUI() {
        view.backgroundColor = .white
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    func setupUI() {
        view.backgroundColor = bgColor
        buttonStack.axis = NSLayoutConstraint.Axis.horizontal
        buttonStack.distribution = UIStackView.Distribution.fillEqually
        buttonStack.alignment = UIStackView.Alignment.center
        
        bookmarksButton.addTarget(self, action: #selector(bookmarksButtonClicked(_sender:)), for: .touchUpInside)
        breakfastCategoryButton.addTarget(self, action: #selector(breakfastButtonClicked), for: .touchUpInside)
        lunchCategoryButton.addTarget(self, action: #selector(lunchButtonClicked(_sender:)), for: .touchUpInside)
        dinnerCategoryButton.addTarget(self, action: #selector(dinnerButtonClicked(_sender:)), for: .touchUpInside)
        
        view.addSubview(tableView)
        view.addSubview(bookmarksButton)
        view.addSubview(buttonStack)
        buttonStack.addSubview(breakfastCategoryButton)
        buttonStack.addSubview(lunchCategoryButton)
        buttonStack.addSubview(dinnerCategoryButton)
        
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        bookmarksButton.translatesAutoresizingMaskIntoConstraints = false
        bookmarksButton.setTitleColor(UIColor.red, for: .normal)
        bookmarksButton.setTitle("Show Favorite Foods", for: .normal)
        bookmarksButton.layer.borderWidth = 1.5
        bookmarksButton.layer.borderColor = UIColor.red.cgColor
        bookmarksButton.backgroundColor = bgColor
        bookmarksButton.layer.cornerRadius = 7
        
        breakfastCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        breakfastCategoryButton.setTitleColor(UIColor.red, for: .normal)
        breakfastCategoryButton.setTitle("American", for: .normal)
        breakfastCategoryButton.layer.borderWidth = 1.5
        breakfastCategoryButton.layer.borderColor = UIColor.red.cgColor
        breakfastCategoryButton.backgroundColor = bgColor
        breakfastCategoryButton.layer.cornerRadius = 7
        
        lunchCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        lunchCategoryButton.setTitleColor(UIColor.red, for: .normal)
        lunchCategoryButton.setTitle("Italian", for: .normal)
        lunchCategoryButton.layer.borderWidth = 1.5
        lunchCategoryButton.layer.borderColor = UIColor.red.cgColor
        lunchCategoryButton.backgroundColor = bgColor
        lunchCategoryButton.layer.cornerRadius = 7
        
        dinnerCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        dinnerCategoryButton.setTitleColor(UIColor.red, for: .normal)
        dinnerCategoryButton.setTitle("Thai", for: .normal)
        dinnerCategoryButton.layer.borderWidth = 1.5
        dinnerCategoryButton.layer.borderColor = UIColor.red.cgColor
        dinnerCategoryButton.backgroundColor = bgColor
        dinnerCategoryButton.layer.cornerRadius = 7
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RecipeTableCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 50
        tableView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            bookmarksButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            bookmarksButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            bookmarksButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            bookmarksButton.heightAnchor.constraint(equalToConstant: 45),
            bookmarksButton.widthAnchor.constraint(equalToConstant: (view.frame.width / 3) - 15),
            
            buttonStack.topAnchor.constraint(equalTo: bookmarksButton.layoutMarginsGuide.topAnchor, constant: 50),
            buttonStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            buttonStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            buttonStack.heightAnchor.constraint(equalToConstant: 45),
            
            breakfastCategoryButton.leadingAnchor.constraint(equalTo: buttonStack.layoutMarginsGuide.leadingAnchor),
            breakfastCategoryButton.widthAnchor.constraint(equalToConstant: (view.frame.width) / 3.5),
            
            lunchCategoryButton.widthAnchor.constraint(equalToConstant: (view.frame.width) / 3.5),
            lunchCategoryButton.centerXAnchor.constraint(equalTo: buttonStack.centerXAnchor),
            lunchCategoryButton.leadingAnchor.constraint(equalTo: breakfastCategoryButton.layoutMarginsGuide.trailingAnchor),
            lunchCategoryButton.trailingAnchor.constraint(equalTo: dinnerCategoryButton.layoutMarginsGuide.leadingAnchor),

            dinnerCategoryButton.trailingAnchor.constraint(equalTo: buttonStack.layoutMarginsGuide.trailingAnchor),
            dinnerCategoryButton.widthAnchor.constraint(equalToConstant: (view.frame.width) / 3.5),
            
            tableView.topAnchor.constraint(equalTo: buttonStack.layoutMarginsGuide.topAnchor, constant: 60),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 20)
        ])
    }
    func addtoBookmarks(food: Food) {
        bookmarks.append(food) 
        if (food.category == 0) {
            
            if let row = self.breakfast.firstIndex(where: {$0.name == food.name}) {
                breakfast[row].isBookmark = true
            }
            toBeLoadedInTable = breakfast
        }
        else if (food.category == 1) {
            if let row = self.lunch.firstIndex(where: {$0.name == food.name}) {
                lunch[row].isBookmark = true
            }
            toBeLoadedInTable = lunch
        }
        else if (food.category == 2) {
            if let row = self.dinner.firstIndex(where: {$0.name == food.name}) {
                dinner[row].isBookmark = true
            }
            toBeLoadedInTable = dinner
        }
        if (bookmarksDisplaying == true){
            toBeLoadedInTable = bookmarks
        }
        tableView.reloadData()
    }
    
    func removeFromBookmarks(food: Food) {
        bookmarks.remove(at: bookmarkIndexOpened)
        if (food.category == 0) {
            if let row = self.breakfast.firstIndex(where: {$0.name == food.name}) {
                breakfast[row].isBookmark = false
            }
            toBeLoadedInTable = breakfast
        }
        else if (food.category == 1) {
            if let row = self.lunch.firstIndex(where: {$0.name == food.name}) {
                lunch[row].isBookmark = false
            }
            toBeLoadedInTable = lunch
        }
        else if (food.category == 2) {
            if let row = self.dinner.firstIndex(where: {$0.name == food.name}) {
                dinner[row].isBookmark = false
            }
            toBeLoadedInTable = dinner
        }
        if (bookmarksDisplaying == true){
            toBeLoadedInTable = bookmarks
        }
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RecipeTableCell
        let category = toBeLoadedInTable[indexPath.row].category
        
        if (category == 0) {
            cell.foodImageView.image = UIImage(named: "0")
        }
        else if (category == 1) {
            cell.foodImageView.image = UIImage(named: "1")
        }
        else if (category == 2) {
            cell.foodImageView.image = UIImage(named: "2")
        }
        cell.foodNameLabel.text = toBeLoadedInTable[indexPath.row].name
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toBeLoadedInTable.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (bookmarksDisplaying) {
            bookmarkIndexOpened = indexPath.row
        }
        let vc = RecipeDetailViewController()
        vc.delegate = self
        vc.food = toBeLoadedInTable[indexPath.row]
        self.present(vc, animated: true)
    }
    
    @objc func bookmarksButtonClicked(_sender: UIButton) {
        bookmarksDisplaying = true
        toBeLoadedInTable = bookmarks
        tableView.reloadData()
    }
    @objc func breakfastButtonClicked(_sender: UIButton) {
        bookmarksDisplaying = false
        toBeLoadedInTable = breakfast
        tableView.reloadData()
    }
    @objc func lunchButtonClicked(_sender: UIButton) {
        bookmarksDisplaying = false
        toBeLoadedInTable = lunch
        tableView.reloadData()
    }
    @objc func dinnerButtonClicked(_sender: UIButton) {
        bookmarksDisplaying = false
        toBeLoadedInTable = dinner
        tableView.reloadData()
    }
}
