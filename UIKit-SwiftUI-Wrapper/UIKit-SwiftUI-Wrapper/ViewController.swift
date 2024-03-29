//
//  ViewController.swift
//  UIKit-SwiftUI-Wrapper
//
//  Created by Cory Popp on 3/29/24.
//

import UIKit

class ViewController: UIViewController {
    
    weak var delegate: ViewControllerDelegate?
    var updatedTitle = "Success!"
    var updatedDescription = "Our ViewController has updated our SwiftUI View"
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Input", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 12
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }
    
    private func setupButton() {
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        delegate?.didChangeValues(title: updatedTitle, description: updatedDescription)
    }
    
    
}

#Preview {
    ViewController()
}
