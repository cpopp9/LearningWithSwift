//
//  CityViewController.swift
//  TableViewProject
//
//  Created by Cory Popp on 3/27/24.
//

import UIKit

class CityViewController: UIViewController {
    let city: String
    
    init(city: String) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = city
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }
}
