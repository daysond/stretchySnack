//
//  ViewController.swift
//  StretchSnacks
//
//  Created by Dayson Dong on 2019-06-13.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    private var snackLabel: UILabel!
    private var stackView: UIStackView!
    private var foods:[String] = []
    private var imageNames = ["oreos","ramen","pizza","tarts","popsicle"]
    private var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foods =  ["oreos","ramen","pizza","tarts","popsicle"]
        setupTitle()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        
        if !isExpanded {
            snackLabel.text = "Add a snack"
            self.setupStackview()
            self.heightConstraint.constant = 200
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: {
                self.view.layoutIfNeeded()
                self.addButton.transform = self.addButton.transform.rotated(by: CGFloat.pi/4.0)
                
            }, completion: nil)
            
        } else {
            snackLabel.text = "Snack"
            self.heightConstraint.constant = 44
            self.stackView.removeFromSuperview()
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: {
                self.view.layoutIfNeeded()
                self.addButton.transform = CGAffineTransform.identity
                
            }, completion: nil)
        }
        
        isExpanded = !isExpanded
    }
    
    @objc func addFood(_ sender: UITapGestureRecognizer) {
        if let view = sender.view {
            foods.insert(imageNames[view.tag], at: 0)
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            
        }
    }
    
    private func setupStackview() {
        var subViews: [UIImageView] = []
        
        for i in 0..<imageNames.count {
            
            let imageView = UIImageView(image: UIImage(named: imageNames[i]))
            let tap = UITapGestureRecognizer(target: self, action: #selector(addFood(_:)))
            imageView.tag = i
            imageView.addGestureRecognizer(tap)
            imageView.isUserInteractionEnabled = true
            subViews.append(imageView)
            
        }
        
        stackView = UIStackView(arrangedSubviews: subViews)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        navBar.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: navBar.heightAnchor, constant: -40),
            stackView.widthAnchor.constraint(equalTo: navBar.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: navBar.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: navBar.centerYAnchor, constant: 20)
            
            ])
    }
    
    func setupTitle() {
        
        let title = UILabel()
        title.text = "Snack"
        title.translatesAutoresizingMaskIntoConstraints = false
        navBar.addSubview(title)
        
        NSLayoutConstraint.activate([
            
            title.topAnchor.constraint(equalTo: navBar.topAnchor, constant: 8),
            title.centerXAnchor.constraint(equalTo: navBar.centerXAnchor)
            
            ])
        snackLabel = title
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = foods[indexPath.row]
        return cell
    }
    
    
}

