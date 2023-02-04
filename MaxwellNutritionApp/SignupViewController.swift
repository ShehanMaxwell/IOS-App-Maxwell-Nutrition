import UIKit
import FirebaseAuth

class signupViewController: UIViewController {
    
    let gradientLayer = CAGradientLayer()
    var backgroundImageView = UIImageView()
    var blurView = UIView()
    var headerLabel = UILabel()
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var errorLabel = UILabel()
    var mainButton = UIButton()
    var topButton = UIButton()
    var loginMode = false
    
    var handle: AuthStateDidChangeListenerHandle?
    let bgColor = UIColor(red: 240.0/255.0, green: 200.0/255.0, blue: 122.0/255.0, alpha: 1)


    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = bgColor
        navigationController?.navigationBar.barTintColor = bgColor
        setupUI()
    }
    func setupUI() {
        assignbackground()
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(mainButton)
        view.addSubview(topButton)
        view.addSubview(errorLabel)
        view.addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        topButton.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerLabel.text = "Maxwell Nutrition"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        headerLabel.textColor = UIColor.red
        headerLabel.textAlignment = .center

        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Email Address",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        
        passwordTextField.isSecureTextEntry = true
        
        emailTextField.borderStyle = .none
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 5
        
        passwordTextField.borderStyle = .none
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 5
        
        errorLabel.textColor = .red
        errorLabel.numberOfLines = 2
        
        mainButton.backgroundColor = .systemRed
        mainButton.setTitle("Sign Up", for: .normal)
        mainButton.addTarget(self, action: #selector(mainButtonClicked), for: .touchUpInside)
        
        topButton.setTitleColor(UIColor.red, for: .normal)
        topButton.setTitle("Log In", for: .normal)
        topButton.addTarget(self, action: #selector(topButtonClicked), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            topButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            topButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -5),
            
            headerLabel.topAnchor.constraint(equalTo: topButton.layoutMarginsGuide.bottomAnchor, constant: 30),
            headerLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 30),
            headerLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -30),
            
            emailTextField.topAnchor.constraint(equalTo: headerLabel.layoutMarginsGuide.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -30),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.layoutMarginsGuide.bottomAnchor, constant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            errorLabel.topAnchor.constraint(equalTo: passwordTextField.layoutMarginsGuide.bottomAnchor, constant: 10),
            errorLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 30),
            errorLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -30),

            mainButton.topAnchor.constraint(equalTo: passwordTextField.layoutMarginsGuide.bottomAnchor, constant: 50),
            mainButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 30),
            mainButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -30),
            mainButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func assignbackground(){
            let background = UIImage(named: "backgroundImage")
            var imageView : UIImageView!
            imageView = UIImageView(frame: view.bounds)
            imageView.contentMode =  UIView.ContentMode.scaleToFill
            imageView.clipsToBounds = true
            imageView.image = background
            imageView.center = view.center
            view.addSubview(imageView)
            self.view.sendSubviewToBack(imageView)
            setGradientBg()
        }
    func setGradientBg() {
        let topColor = UIColor(red: 240.0/255.0, green: 200.0/255.0, blue: 122.0/255.0, alpha: 0.95).cgColor
        let midColor = UIColor(red: 240.0/255.0, green: 200.0/255.0, blue: 122.0/255.0, alpha: 0.95).cgColor
        let midColor1 = UIColor(red: 240.0/255.0, green: 200.0/255.0, blue: 122.0/255.0, alpha: 0.8).cgColor
        let bottomColor = UIColor(red: 240.0/255.0, green: 200.0/255.0, blue: 122.0/255.0, alpha: 0.1).cgColor
        let bottomColor1 = UIColor(red: 240.0/255.0, green: 200.0/255.0, blue: 122.0/255.0, alpha: 0).cgColor
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, midColor,midColor1, bottomColor, bottomColor1]
        view.layer.insertSublayer(gradientLayer, at: 1)
    }
    @objc func mainButtonClicked(_sender: UIButton) {
        errorLabel.text = ""
        guard
          let email = emailTextField.text,
          let password = passwordTextField.text,
          !email.isEmpty,
          !password.isEmpty
        else {
            if (loginMode) {
                errorLabel.text = "Unable to login"
            }
            else {
                errorLabel.text = "Unable to sign up"
            }
            return
        }
        
        if (loginMode == false) {
            createUser(email: email, password: password)
        }
        else {
            loginUser(email: email, password: password)
        }
    }
    @objc func topButtonClicked(_sender: UIButton) {
        errorLabel.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        
        if (loginMode) {
            loginMode = false
            mainButton.setTitle("Sign Up", for: .normal)
            topButton.setTitle("Log In", for: .normal)
        }
        else {
            loginMode = true
            mainButton.setTitle("Log In", for: .normal)
            topButton.setTitle("Sign Up", for: .normal)
        }
    }
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
          if error == nil {
              self.loginUser(email: email, password: password)
          } else {
              self.errorLabel.text = error?.localizedDescription
          }
        }
    }
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
          if let error = error, user == nil {
              self.errorLabel.text = error.localizedDescription
          }
            else {
                let homeVC = HomeViewController()
                self.view.window?.rootViewController = homeVC
            }
        }
    }
}

