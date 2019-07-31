//
//  ViewController.swift
//  CBFlashyTabBarController
//
//  Created by askopin@gmail.com on 11/29/2018.
//  Copyright (c) 2018 askopin@gmail.com. All rights reserved.
//

import UIKit
import VpsvilleUIController

extension String: CBTabMenuItem {
    public var title: String? { return self }
    public var attributedTitle: NSAttributedString? { return nil }
}

class SampleTabItem: UITabBarItem, CBExtendedTabItem {
    
    public var attributedTitle: NSAttributedString? {
        guard let title = title else { return nil }
        return NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red,
                                                              NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
    }
}

class ViewController: UIViewController {
    var loginView: LoginView!
    //let defaults = UserDefaults.standard
    //    var btnClose: UIButton = {
    //        var btn = UIButton()
    //        btn.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    //        btn.setImage(#imageLiteral(resourceName: "btnClose").withRenderingMode(.alwaysTemplate), for: .normal)
    //        btn.translatesAutoresizingMaskIntoConstraints = false
    //        return btn
    //    }()
    
    //    @objc func btnClosePressed() {
    //        //UserDefaults.standard.set(false, forKey: "LogedIn")
    //        //UserDefaults.standard.synchronize()
    //        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        self.hideKeyboardWhenTappedAround()
        //        view.backgroundColor = UIColor.red
        //        view.addSubview(btnClose)
        //
        //        btnClose.widthAnchor.constraint(equalToConstant: 45).isActive = true
        //        btnClose.heightAnchor.constraint(equalToConstant: 45).isActive = true
        //        let guide = view.layoutMarginsGuide
        //        btnClose.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0).isActive = true
        //        btnClose.trailingAnchor.constraint(equalToSystemSpacingAfter: guide.trailingAnchor, multiplier: 1.0).isActive = true
        //        btnClose.addTarget(self, action: #selector(btnClosePressed), for: .touchUpInside)
        
        if isLogged() {
            let tabBarController = createSampleTabController()
            tabBarController.style = .flashy
            self.navigationController?.pushViewController(tabBarController, animated: true)
        }
        else {
            print ("nice keytrue = 0")
            self.navigationController?.isNavigationBarHidden = true
        }
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
        print(email, password)
        guard let jsonUrlString = URL(string: "https://vpsville.ru/api/1.0/login") else { return }
        var request = URLRequest(url: jsonUrlString)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let postString = "login=\(email)&password=\(password)"
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {guard let data = data else {return}
                let responseString = String(data: data, encoding: .utf8)
                if (responseString == Optional("")) {print("no")}
                else {
                    print("responseString = \(responseString)")
                    //print(UserDefaults.standard.string(forKey: "tokenKey")!)
                    //if (UserDefaults.standard.string(forKey: "tokenKey") != nil) {
                    UserDefaults.standard.set(responseString!, forKey: "tokenKey")
                    UserDefaults.standard.set(true, forKey: "LogedIn")
                    UserDefaults.standard.synchronize()
                    let tabBarController = self.createSampleTabController()
                    let menuEntries = ["Написать нам", "Оформить сеть", "Создать сервер"]
                    let menu = CBTabMenu(menuButtonIndex: 2,
                                         menuColor: #colorLiteral(red: 0, green: 0.3019607843, blue: 0.8235294118, alpha: 1),
                                         items: menuEntries,
                                         icon: nil,
                                         callback: { controller, item in
                                            controller.dismiss(animated: true, completion: {
                                                print("\(item) selected")
                                            })
                    })
                    tabBarController.style = .gooey(menu: menu)
                    //tabBarController.style = .flashy
                    self.navigationController?.pushViewController(tabBarController, animated: true)
                    //}
                }
                
            }
            }.resume()
    }
    
    func signupPressed() {
        // 1
        //        let signUpVC = SignUpController()
        //        present(signUpVC, animated: true, completion: nil)
        print("sign")
    }
    
    fileprivate func isLogged() -> Bool {
        return UserDefaults.standard.bool(forKey: "LogedIn")
    }
    
    func createSampleTabController() -> CBTabBarController {
        let layout = UICollectionViewFlowLayout()
        let layout2 = UICollectionViewFlowLayout()
        let mainVC = MainController(collectionViewLayout: layout)
        mainVC.tabBarItem = UITabBarItem(title: "Главная", image: #imageLiteral(resourceName: "house50"), tag: 0)
        let paymentVC = Payment()
        paymentVC.tabBarItem = UITabBarItem(title: "Оплата", image: #imageLiteral(resourceName: "money48"), tag: 0)
        let plansVC = PlansController(collectionViewLayout: layout2)
        plansVC.tabBarItem = UITabBarItem(title: "Тарифы", image: #imageLiteral(resourceName: "bull50"), tag: 0)
        let settingsVC = SettingsController()
        settingsVC.tabBarItem = UITabBarItem(title: "Настройки", image: #imageLiteral(resourceName: "Settings"), tag: 0)//SampleTabItem(title:
        
        let tabBarController = CBTabBarController()
        tabBarController.viewControllers = [mainVC, plansVC, paymentVC, settingsVC]
        return tabBarController
    }
    
    //    @IBAction func btnFlashyPressed(_ sender: AnyObject) {
    //        let tabBarController = createSampleTabController()
    //        tabBarController.style = .flashy
    //        self.navigationController?.pushViewController(tabBarController, animated: true)
    //    }
    
    //    @IBAction func btnGooeyPressed(_ sender: AnyObject) {
    //        let tabBarController = createSampleTabController()
//            let menuEntries = ["Написать нам", "Оформить сеть", "Создать сервер"]
//            let menu = CBTabMenu(menuButtonIndex: 2,
//                                 menuColor: #colorLiteral(red: 0.368781209, green: 0.6813176274, blue: 1, alpha: 1),
//                                 items: menuEntries,
//                                 icon: nil,
//                                 callback: { controller, item in
//                                    controller.dismiss(animated: true, completion: {
//                                        print("\(item) selected")
//                                    })
//            })
//            tabBarController.style = .gooey(menu: menu)
//
//            self.navigationController?.pushViewController(tabBarController, animated: true)
//        }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
