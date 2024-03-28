//
//  ViewController.swift
//  TableViewProject
//
//  Created by Cory Popp on 3/27/24.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.allowsSelection = true
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
        
    }()
    
    let cities: [String] = [
    "Philadelphia",
    "New York",
    "Chicago",
    "Denver",
    "Los Angeles",
    "Dallas"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .white
        title = "TableView"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        buildTableView()
    }
    
    func buildTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cities[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(CityViewController(city: cities[indexPath.row]), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

#Preview {
    ViewController()
}

