//
//  ViewController.swift
//  OPS
//
//  Created by Happy Sanz Tech on 29/09/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = APIURL.url + APIFunctionName.appVersion
        print(url,"Test")
    }


}

