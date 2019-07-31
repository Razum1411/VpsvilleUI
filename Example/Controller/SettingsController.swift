//
//  ViewController.swift
//  SettingsTemplate
//
//  Created by Stephen Dowless on 2/10/19.
//  Copyright © 2019 Stephan Dowless. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SettingsCell"

class SettingsController: UIViewController {
    
    // MARK: - Properties
    
    var tableView: UITableView!
    var userInfoHeader: UserInfoHeader!
    
    // MARK: - Init
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: - Helper Functions
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame
//        let topFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 160)
//        let topView = UIView(frame: topFrame)
//        topView.backgroundColor = #colorLiteral(red: 0.2, green: 0.6, blue: 1, alpha: 1)
//        view.addSubview(topView)
        
//        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
//        userInfoHeader = UserInfoHeader(frame: frame)
//        tableView.tableHeaderView = userInfoHeader
        tableView.tableFooterView = UIView()
    }
    
    func configureUI() {
        configureTableView()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        navigationItem.title = "Настройки"
    }
    
}

extension SettingsController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        
        
        return SocialOptions.allCases.count
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        
        print("Section is \(section)")
        
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .white
        title.text = SettingsSection(rawValue: section)?.description
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        
        let social = SocialOptions(rawValue: indexPath.row)
        cell.sectionType = social
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //guard let section = SettingsSection(rawValue: indexPath.section) else { return }
        UserDefaults.standard.set(false, forKey: "LogedIn")
        UserDefaults.standard.synchronize()
        navigationController?.popToRootViewController(animated: true)
        
        //print(SocialOptions(rawValue: indexPath.row)?.description)
        
    }
}

