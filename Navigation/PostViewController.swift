//
//  PostViewController.swift
//  Navigation
//
//  Created by Shalopay on 27.05.2022.
//

import UIKit

class PostViewController: UIViewController {
    private lazy var titlePost: String = "Shalopay"
    private lazy var barButtonItem = UIBarButtonItem(title: "Инфо", style: .plain, target: self, action: #selector(tapBarButton))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.title = titlePost
        self.view.backgroundColor = .lightGray
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    @objc func tapBarButton(){
        print("Инфо")
        let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .automatic
        self.present(infoVC, animated: true, completion: nil)
        
    }
}
