//
//  CBSampleViewController.swift
//  CBFlashyTabBarController_Example
//
//  Created by Anton Skopin on 03/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class PlansController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var plans: [Plans]?
    //    var servers: [Server] = {
    //        var test1 = Server()
    //        test1.name = "test"
    //        test1.cpu = 500
    //        test1.mem = 200
    //        test1.ip = "sss"
    //        var test2 = Server()
    //        test2.name = "test"
    //        var test3 = Server()
    //        test3.name = "test"
    //        return [test1,test2,test3]
    //    }()
    //    var nice: [Int]?
    
    //var vpsServers: UITableView
    //  var kek: UI
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchServers()
        collectionView?.backgroundColor = UIColor.white
        //        lblTitle.text = "Nice test"//tabBarItem.title
        //        view.addSubview(lblTitle)
        //
        //        let frameText = CGRect(x: 10, y: 20, width: 200, height: 30)
        //        let labelText = UILabel(frame: frameText)
        //        labelText.text = "Логин:"
        //        labelText.textAlignment = .left
        //        labelText.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        //        labelText.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //        self.view.addSubview(labelText)
        //
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
        
        //        lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //        lblTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.setNeedsLayout()
        collectionView.register(PlanCell.self, forCellWithReuseIdentifier: "cellId")
        let account = Plans.init()
        account.updateInfo() { (account) in
            if let data = account {
                //print(data.inn, data.login, data.money)
                DispatchQueue.main.async {
                    for i in 0..<data.count {
                    print(data[i].name)
                    }
                }
            }
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plans?.count ?? 0//self.nice?.count ?? 0
    }
    
    func fetchServers() {
        guard let jsonUrlString = URL(string: "https://vpsville.ru/api/1.0/configuration/plans") else { return }
        var request = URLRequest(url: jsonUrlString)
        request.httpMethod = "GET"
        request.addValue("application", forHTTPHeaderField: "accept")
        request.addValue(UserDefaults.standard.string(forKey: "tokenKey")!, forHTTPHeaderField: "vpsville-api-key")
        //var json = [AccountInfo()]
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            DispatchQueue.main.async {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    //for i in 0..<json.count {
                    self.plans = [Plans]()
                    for dictionary in json as! [[String: AnyObject]] {
                        let test = Plans()
                        test.name = (dictionary["name"] as? String)!
                        test.cpu = (dictionary["cpu"] as? String)!
                        test.memory = (dictionary["memory"] as? String)!
                        test.disk = (dictionary["disk"] as? String)!
                        test.money = (dictionary["money"] as? String)!
                        self.plans?.append(test)
                    }
                    //test.name = json[i].name as String
                    //self.servers?.append(test)
                    //print(json[0].login)
                    //}
                    self.collectionView?.reloadData()
                    //                self.viewname = json[i].viewname
                    //                self.mem = json[i].mem
                    //                self.cpu = json[i].cpu
                    //                self.status = json[i].status
                    //                self.os = json[i].os
                    //                self.disk = json[i].disk
                    //                self.last_action_time = json[i].last_action_time
                    //                self.created_time = json[i].created_time
                    //                }
                    // self.nice?.append(1)
                    // self.collectionView.reloadData()
                    //print(self.nice?.count)
                }
                catch let jsonErr {
                    print ("error with JSONDecoding: \(jsonErr)")
                }
            }
            }.resume()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PlanCell
        cell.plans = plans?[indexPath.item]
        //cell.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
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


