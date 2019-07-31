//
//  LoginViewController.swift
//  ExampleApp
//
//  Created by An Zuzu on 18.05.2019.
//  Copyright © 2019 cuberto. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginView: LoginView!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupView() {
        let mainView = LoginView(frame: self.view.frame)
        self.loginView = mainView
        self.loginView.loginAction = loginPressed
        self.loginView.signupAction = signupPressed
        self.view.addSubview(loginView)
        loginView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    func loginPressed() {
        guard let email = loginView.emailTextField.text else { return }
        guard let password = loginView.passwordTextField.text else { return }
//       print(email, password)
//        guard let jsonUrlString = URL(string: "https://vpsville.ru/api/1.0/login") else { return }
//        var request = URLRequest(url: jsonUrlString)
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        let postString = "login=\(email)&password=\(password)"
//        request.httpMethod = "POST"
//        request.httpBody = postString.data(using: .utf8)
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            guard let data = data else {return}
//            let responseString = String(data: data, encoding: .utf8)
//            print("responseString = \(responseString)")
//            UserDefaults.standard.set(responseString!, forKey: "tokenKey")
//            print(UserDefaults.standard.string(forKey: "tokenKey") ?? "hui")
//            }.resume()
    }
    
    func signupPressed() {
        // 1
//        let signUpVC = SignUpController()
//        present(signUpVC, animated: true, completion: nil)
        print("sign")
    }
    
}
