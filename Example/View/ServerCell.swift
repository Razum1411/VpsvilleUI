//
//  ServerCell.swift
//  ExampleApp
//
//  Created by An Zuzu on 15.05.2019.
//  Copyright © 2019 cuberto. All rights reserved.
//

import UIKit

class ServerCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: CGRect.init())
        setupViews()
    }
    
    var servers: Server? {
        didSet {
            self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            serverName.text = servers?.name
            serverName.font = UIFont(name: "GillSans-SemiBoldItalic", size: 18.0)
            serverName.textAlignment = .left
            serverIp.text = "ip: \(servers!.ip)"
            serverIp.textAlignment = .left
            serverIp.font = UIFont(name: "GillSans", size: 18.0)
            if let test1 = servers?.cpu as? Int {
                serverCPU.text = "CPU: \(String(test1))"
                serverCPU.textAlignment = .left
                serverCPU.font = UIFont(name: "GillSans", size: 18.0)
            }
            if let test2 = servers?.mem as? Int {
                serverRAM.text = "RAM: \(String(test2))"
                serverRAM.textAlignment = .left
                serverRAM.font = UIFont(name: "GillSans", size: 18.0)
            }
            serverIcon.image = #imageLiteral(resourceName: "serverIcon")
            var myString: String
            var myMutableString = NSMutableAttributedString()
            switch servers?.status {
                case "active":
                //serverIcon.backgroundColor = UIColor.green
                    myString = "Состояние: Активен"
                    myMutableString = NSMutableAttributedString(string: myString, attributes: [NSAttributedString.Key.font :UIFont(name: "GillSans", size: 18.0)!])
                    myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: NSRange(location:11,length:7))
                    serverStatus.attributedText = myMutableString
                serverStatus.textAlignment = .left
                case "created":
                    myString = "Cостояние: Остановлен"
                    myMutableString = NSMutableAttributedString(string: myString, attributes: [NSAttributedString.Key.font :UIFont(name: "GillSans", size: 18.0)!])
                    myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:11,length:10))
                    serverStatus.attributedText = myMutableString
                serverStatus.textAlignment = .left

                default:
                    myString = "Cостояние: Остановлен"
                    myMutableString = NSMutableAttributedString(string: myString, attributes: [NSAttributedString.Key.font :UIFont(name: "GillSans", size: 18.0)!])
                    myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:11,length:10))
                    serverStatus.attributedText = myMutableString
                serverStatus.textAlignment = .left
            }
        }
    }
    
    let serverIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    
    let serverName: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        let servers = Server.init()
//        servers.updateInfo() { (price) in
//            if let data = price {
//                DispatchQueue.main.async {
//                label.text = data[0].name
//                }
//            }
//        }
        return label
    }()
    
    let serverIp: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let serverStatus: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let serverCPU: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let serverRAM: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.6, blue: 1, alpha: 1)
        return view
    }()
    
    func setupViews () {
        //backgroundColor = UIColor.blue
        addSubview(serverIcon)
        addSubview(separatorView)
        addSubview(serverName)
        addSubview(serverIp)
        addSubview(serverCPU)
        addSubview(serverRAM)
        addSubview(serverStatus)
        //serverIcon.frame = CGRect(x: 25, y: 25, width: 100, height: 100)
        addConstraintsWithFormat(format: "H:|-1-[v0(100)]-25-|", views: serverIcon)
        addConstraintsWithFormat(format: "V:|-25-[v0(100)]-25-[v1(1)]|", views: serverIcon, separatorView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        // labels
        addConstraint(NSLayoutConstraint(item: serverName, attribute: .left, relatedBy: .equal, toItem: serverIcon, attribute: .right, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: serverName, attribute: .top, relatedBy: .equal, toItem: serverIcon, attribute: .top, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: serverName, attribute: .right, relatedBy: .equal, toItem: serverIcon, attribute: .right, multiplier: 1, constant: 208))
        
        addConstraint(NSLayoutConstraint(item: serverName, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        // labels 2
        addConstraint(NSLayoutConstraint(item: serverIp, attribute: .left, relatedBy: .equal, toItem: serverIcon, attribute: .right, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: serverIp, attribute: .top, relatedBy: .equal, toItem: serverName, attribute: .bottom, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: serverIp, attribute: .right, relatedBy: .equal, toItem: serverIcon, attribute: .right, multiplier: 1, constant: 208))
        
        addConstraint(NSLayoutConstraint(item: serverIp, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //label 3
        
        addConstraint(NSLayoutConstraint(item: serverCPU, attribute: .left, relatedBy: .equal, toItem: serverIcon, attribute: .right, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: serverCPU, attribute: .top, relatedBy: .equal, toItem: serverIp, attribute: .bottom, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: serverCPU, attribute: .right, relatedBy: .equal, toItem: serverIcon, attribute: .right, multiplier: 1, constant: 104))
        
        addConstraint(NSLayoutConstraint(item: serverCPU, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //label 4
        addConstraint(NSLayoutConstraint(item: serverRAM, attribute: .left, relatedBy: .equal, toItem: serverIcon, attribute: .right, multiplier: 1, constant: 96))

        addConstraint(NSLayoutConstraint(item: serverRAM, attribute: .top, relatedBy: .equal, toItem: serverIp, attribute: .bottom, multiplier: 1, constant: 8))

        addConstraint(NSLayoutConstraint(item: serverRAM, attribute: .right, relatedBy: .equal, toItem: serverIcon, attribute: .right, multiplier: 1, constant: 208))
        addConstraint(NSLayoutConstraint(item: serverRAM, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //label 5
        addConstraint(NSLayoutConstraint(item: serverStatus, attribute: .left, relatedBy: .equal, toItem: serverIcon, attribute: .right, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: serverStatus, attribute: .top, relatedBy: .equal, toItem: serverCPU, attribute: .bottom, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: serverStatus, attribute: .right, relatedBy: .equal, toItem: serverIcon, attribute: .right, multiplier: 1, constant: 208))
        addConstraint(NSLayoutConstraint(item: serverStatus, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))

//        addConstraint(NSLayoutConstraint(item: serverRAM, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
//        addConstraintsWithFormat(format: "V:|[v0(20)]|", views: serverName)
//        addConstraintsWithFormat(format: "H:|[v0]|", views: serverName)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
