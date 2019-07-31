////
////  ViewController.swift
////  CBFlashyTabBarController
////
////  Created by askopin@gmail.com on 11/29/2018.
////  Copyright (c) 2018 askopin@gmail.com. All rights reserved.
////
//
//import UIKit
//import VpsvilleUIController
//
//extension String: CBTabMenuItem {
//    public var title: String? { return self }
//    public var attributedTitle: NSAttributedString? { return nil }
//}
//
//class SampleTabItem: UITabBarItem, CBExtendedTabItem {
//
//    public var attributedTitle: NSAttributedString? {
//        guard let title = title else { return nil }
//        return NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red,
//                                                              NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
//    }
//}
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor.red
//        if isLogged() {
//            let tabBarController = createSampleTabController()
//            tabBarController.style = .flashy
//            self.navigationController?.pushViewController(tabBarController, animated: true)
//        }
//        else {
//            self.navigationController?.isNavigationBarHidden = true
//        }
//    }
//
//    fileprivate func isLogged() -> Bool {
//        return UserDefaults.standard.bool(forKey: "LogedIn")
//    }
//
//    func createSampleTabController() -> CBTabBarController {
//        let layout = UICollectionViewFlowLayout()
//        let mainVC = MainController(collectionViewLayout: layout)
//        mainVC.tabBarItem = UITabBarItem(title: "Главная", image: #imageLiteral(resourceName: "house50"), tag: 0)
//        let paymentVC = Payment()
//        paymentVC.tabBarItem = UITabBarItem(title: "Оплата", image: #imageLiteral(resourceName: "money48"), tag: 0)
//        let plansVC = CBSampleViewController()
//        plansVC.tabBarItem = UITabBarItem(title: "Тарифы", image: #imageLiteral(resourceName: "bull50"), tag: 0)
//        let settingsVC = CBSampleViewController()
//        settingsVC.tabBarItem = UITabBarItem(title: "Настройки", image: #imageLiteral(resourceName: "Settings"), tag: 0)//SampleTabItem(title: "Настройки", image: #imageLiteral(resourceName: "Settings"), tag: 0)
//        //settingsVC.tabBarItem?.badgeColor = .red
//        /*DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//         settingsVC.tabBarItem?.badgeValue = "20"
//         }
//         DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//         settingsVC.tabBarItem?.badgeValue = "200"
//         }*/
//        //settingsVC.tabBarItem?.badgeValue = "1"
//        //settingsVC.inverseColor()
//
//        let tabBarController = CBTabBarController()
//        tabBarController.viewControllers = [mainVC, plansVC, paymentVC, settingsVC]
//        return tabBarController
//    }
//
//    @IBAction func btnFlashyPressed(_ sender: AnyObject) {
//        let tabBarController = createSampleTabController()
//        tabBarController.style = .flashy
//        self.navigationController?.pushViewController(tabBarController, animated: true)
//    }
//
//    @IBAction func btnGooeyPressed(_ sender: AnyObject) {
//        let tabBarController = createSampleTabController()
//        let menuEntries = ["Reminder", "Camera", "Attachment", "Text Note"]
//        let menu = CBTabMenu(menuButtonIndex: 2,
//                             menuColor: #colorLiteral(red: 0.368781209, green: 0.6813176274, blue: 1, alpha: 1),
//                             items: menuEntries,
//                             icon: nil,
//                             callback: { controller, item in
//                                controller.dismiss(animated: true, completion: {
//                                    print("\(item) selected")
//                                })
//        })
//        tabBarController.style = .gooey(menu: menu)
//
//        self.navigationController?.pushViewController(tabBarController, animated: true)
//    }
//
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
//
//}





/////////////////////////////////////test2


//
//  ViewController.swift
//  CBFlashyTabBarController
//
//  Created by askopin@gmail.com on 11/29/2018.
//  Copyright (c) 2018 askopin@gmail.com. All rights reserved.
//

//import UIKit
//import VpsvilleUIController
//
//extension String: CBTabMenuItem {
//    public var title: String? { return self }
//    public var attributedTitle: NSAttributedString? { return nil }
//}
//
//class SampleTabItem: UITabBarItem, CBExtendedTabItem {
//    
//    public var attributedTitle: NSAttributedString? {
//        guard let title = title else { return nil }
//        return NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red,
//                                                              NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
//    }
//}
//
//class ViewController: UIViewController {
//    
//    var btnClose: UIButton = {
//        var btn = UIButton()
//        btn.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
//        btn.setImage(#imageLiteral(resourceName: "btnClose").withRenderingMode(.alwaysTemplate), for: .normal)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        return btn
//    }()
//    
//    @objc func btnClosePressed() {
//        //UserDefaults.standard.set(false, forKey: "LogedIn")
//        //UserDefaults.standard.synchronize()
//        self.navigationController?.pushViewController(LoginViewController(), animated: true)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor.red
//        view.addSubview(btnClose)
//        
//        btnClose.widthAnchor.constraint(equalToConstant: 45).isActive = true
//        btnClose.heightAnchor.constraint(equalToConstant: 45).isActive = true
//        let guide = view.layoutMarginsGuide
//        btnClose.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0).isActive = true
//        btnClose.trailingAnchor.constraint(equalToSystemSpacingAfter: guide.trailingAnchor, multiplier: 1.0).isActive = true
//        btnClose.addTarget(self, action: #selector(btnClosePressed), for: .touchUpInside)
//        
//        if isLogged() {
//            let tabBarController = createSampleTabController()
//            tabBarController.style = .flashy
//            self.navigationController?.pushViewController(tabBarController, animated: true)
//        }
//        else {
//            self.navigationController?.isNavigationBarHidden = true
//        }
//    }
//    
//    fileprivate func isLogged() -> Bool {
//        return UserDefaults.standard.bool(forKey: "LogedIn")
//    }
//    
//    func createSampleTabController() -> CBTabBarController {
//        let layout = UICollectionViewFlowLayout()
//        let mainVC = MainController(collectionViewLayout: layout)
//        mainVC.tabBarItem = UITabBarItem(title: "Главная", image: #imageLiteral(resourceName: "house50"), tag: 0)
//        let paymentVC = Payment()
//        paymentVC.tabBarItem = UITabBarItem(title: "Оплата", image: #imageLiteral(resourceName: "money48"), tag: 0)
//        let plansVC = CBSampleViewController()
//        plansVC.tabBarItem = UITabBarItem(title: "Тарифы", image: #imageLiteral(resourceName: "bull50"), tag: 0)
//        let settingsVC = CBSampleViewController()
//        settingsVC.tabBarItem = UITabBarItem(title: "Настройки", image: #imageLiteral(resourceName: "Settings"), tag: 0)//SampleTabItem(title: "Настройки", image: #imageLiteral(resourceName: "Settings"), tag: 0)
//        //settingsVC.tabBarItem?.badgeColor = .red
//        /*DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//         settingsVC.tabBarItem?.badgeValue = "20"
//         }
//         DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//         settingsVC.tabBarItem?.badgeValue = "200"
//         }*/
//        //settingsVC.tabBarItem?.badgeValue = "1"
//        //settingsVC.inverseColor()
//        
//        let tabBarController = CBTabBarController()
//        tabBarController.viewControllers = [mainVC, plansVC, paymentVC, settingsVC]
//        return tabBarController
//    }
//    
//    //    @IBAction func btnFlashyPressed(_ sender: AnyObject) {
//    //        let tabBarController = createSampleTabController()
//    //        tabBarController.style = .flashy
//    //        self.navigationController?.pushViewController(tabBarController, animated: true)
//    //    }
//    
//    //    @IBAction func btnGooeyPressed(_ sender: AnyObject) {
//    //        let tabBarController = createSampleTabController()
//    //        let menuEntries = ["Reminder", "Camera", "Attachment", "Text Note"]
//    //        let menu = CBTabMenu(menuButtonIndex: 2,
//    //                             menuColor: #colorLiteral(red: 0.368781209, green: 0.6813176274, blue: 1, alpha: 1),
//    //                             items: menuEntries,
//    //                             icon: nil,
//    //                             callback: { controller, item in
//    //                                controller.dismiss(animated: true, completion: {
//    //                                    print("\(item) selected")
//    //                                })
//    //        })
//    //        tabBarController.style = .gooey(menu: menu)
//    //
//    //        self.navigationController?.pushViewController(tabBarController, animated: true)
//    //    }
//    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
//    
//}
//
