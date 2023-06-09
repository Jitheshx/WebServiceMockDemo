//
//  ViewController.swift
//  WebServiceMockDemo
//
//  Created by Jithesh Xavier on 09/06/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //1
        let url = URL(string: "https://itunes.apple.com/search?term=prodigy&limit=1")!
        //2
        let networkClient = NetworkClient()
        //3
        networkClient.searchItunes(url: url) { trackStore, errorMessage  in
            //4
            print(trackStore ?? "")
            print(trackStore?.results?.first ?? "")
            print(errorMessage ?? "")
        }
    }
}

