//
//  CBSampleViewController.swift
//  CBFlashyTabBarController_Example
//
//  Created by Anton Skopin on 03/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class MainController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var servers: [Server]?
    
    var noServers: UILabel = {
        var label = UILabel()
        label.textColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 30.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var lblTitle: UILabel = {
        var label = UILabel()
        label.textColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 55.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    var btnClose: UIButton = {
        var btn = UIButton()
        btn.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btn.setImage(#imageLiteral(resourceName: "btnClose").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchServers()
        collectionView?.backgroundColor = UIColor.white
        //        lblTitle.text = "Nice test"//tabBarItem.title
        //        view.addSubview(lblTitle)
        let topFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 160)
        let topView = UIView(frame: topFrame)
        topView.backgroundColor = #colorLiteral(red: 0.2, green: 0.6, blue: 1, alpha: 1)
        view.addSubview(topView)
        //
        //        let frameText = CGRect(x: 10, y: 20, width: 200, height: 30)
        //        let labelText = UILabel(frame: frameText)
        //        labelText.text = "Логин:"
        //        labelText.textAlignment = .left
        //        labelText.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        //        labelText.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //        self.view.addSubview(labelText)
        //
        let account = AccountInfo.init()
        account.updateInfo() { (account) in
            if let data = account {
                //print(data.inn, data.login, data.money)
                DispatchQueue.main.async {
                    let frameText = CGRect(x: 10, y: 20, width: UIScreen.main.bounds.width, height: 60)
                    let labelText = UILabel(frame: frameText)
                    labelText.text = "Логин: \(data.login)"
                    labelText.textAlignment = .left
                    labelText.font = UIFont(name: "GillSans", size: 20.0)
                    labelText.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    self.view.addSubview(labelText)
                    let frameBalance = CGRect(x: 10, y: 50, width: UIScreen.main.bounds.width, height: 60)
                    let labelBalance = UILabel(frame: frameBalance)
                    labelBalance.text = "Баланс: \(data.money) руб"
                    labelBalance.textAlignment = .left
                    labelBalance.font = UIFont(name: "GillSans", size: 20.0)
                    labelBalance.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    self.view.addSubview(labelBalance)
                    if (data.money == "0") {
                        self.noServers.text = "Сервера отсутсвуют"//tabBarItem.title
                        self.view.addSubview(self.noServers)
                        self.noServers.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                        self.noServers.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
                    }
                }
            }
        }
        print(account.money)
        let balance = account.money
        print(balance)
        let price = Price.init()
        price.updateInfo() { (price) in
            if let data = price {
                DispatchQueue.main.async {
                    let frameText = CGRect(x: 10, y: 80, width: UIScreen.main.bounds.width, height: 60)
                    let labelText = UILabel(frame: frameText)
                    labelText.text = "Тариф: \(data.total) руб/мес"
                    labelText.textAlignment = .left
                    labelText.font = UIFont(name: "GillSans", size: 20.0)
                    labelText.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    self.view.addSubview(labelText)
                    let frameRemain = CGRect(x: 10, y: 110, width: UIScreen.main.bounds.width, height: 60)
                    let labelRemain = UILabel(frame: frameRemain)
                    var summCost = Float(account.money) ?? 0
                    if (Float(data.total) == 0) {data.total = 1}
                    summCost = summCost / (Float(data.total) / 30) // костыль от краша из-за nil
                    labelRemain.text = "Хватит на: \(Int(summCost)) дней"
                    labelRemain.textAlignment = .left
                    labelRemain.font = UIFont(name: "GillSans", size: 20.0)
                    labelRemain.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    self.view.addSubview(labelRemain)
                }
            }
        }
        //        let frameText = CGRect(x: 10, y: 80, width: UIScreen.main.bounds.width, height: 60)
        //        let labelText = UILabel(frame: frameText)
        //        labelText.text = "Ежемесячная плата:"
        //        labelText.textAlignment = .left
        //        labelText.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        //        labelText.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //        self.view.addSubview(labelText)
        
        //        let frameRemain = CGRect(x: 10, y: 110, width: UIScreen.main.bounds.width, height: 60)
        //        let labelRemain = UILabel(frame: frameRemain)
        //        labelRemain.text = "Хватит на: \(price.total)"
        //        labelRemain.textAlignment = .left
        //        labelRemain.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        //        labelRemain.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //        self.view.addSubview(labelRemain)
//        view.addSubview(btnClose)
//        btnClose.widthAnchor.constraint(equalToConstant: 45).isActive = true
//        btnClose.heightAnchor.constraint(equalToConstant: 45).isActive = true
//        let guide = view.layoutMarginsGuide
//        btnClose.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0).isActive = true
//        btnClose.trailingAnchor.constraint(equalToSystemSpacingAfter: guide.trailingAnchor, multiplier: 1.0).isActive = true
//        btnClose.addTarget(self, action: #selector(btnClosePressed), for: .touchUpInside)
        view.setNeedsLayout()
        collectionView.register(ServerCell.self, forCellWithReuseIdentifier: "cellId")
//        if (servers!.count == 0) {
//            noServers.text = "Сервера отсутсвуют"//tabBarItem.title
//            view.addSubview(noServers)
//            noServers.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//            noServers.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return servers?.count ?? 0//self.nice?.count ?? 0
    }
    
    func fetchServers() {
        guard let jsonUrlString = URL(string: "https://vpsville.ru/api/1.0/servers") else { return }
        var request = URLRequest(url: jsonUrlString)
        request.httpMethod = "GET"
        request.addValue("application", forHTTPHeaderField: "accept")
        request.addValue(UserDefaults.standard.string(forKey: "tokenKey")!, forHTTPHeaderField: "vpsville-api-key")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            DispatchQueue.main.async {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        self.servers = [Server]()
                    for dictionary in json as! [[String: AnyObject]] {
                        let test = Server()
                        test.name = (dictionary["name"] as? String)!
                        test.ip = (dictionary["ip"] as? String)!
                        test.cpu = (dictionary["cpu"] as? Int)!
                        test.mem = (dictionary["mem"] as? Int)!
                        test.status = (dictionary["status"] as? String)!
                        self.servers?.append(test)
                    }
                    
                    self.collectionView?.reloadData()
                                    }
                catch let jsonErr {
                    print ("error with JSONDecoding: \(jsonErr)")
                }
            }
            }.resume()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 140)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ServerCell
        cell.servers = servers?[indexPath.item]
        //cell.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    func inverseColor() {
        view.backgroundColor = lblTitle.textColor
        lblTitle.textColor = UIColor.white
        btnClose.tintColor = .white
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return view.backgroundColor == UIColor.white ? .default : .lightContent
    }
    
    @objc func btnClosePressed() {
        //UserDefaults.standard.set(false, forKey: "LogedIn")
        //UserDefaults.standard.set(nil, forKey: "tokenKey")
        UserDefaults.standard.set(false, forKey: "LogedIn")
        UserDefaults.standard.synchronize()
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}


