//
//  WebViewController.swift
//  The Foodie
//
//  Created by Shady Adel on 29/06/2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    var targetURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: targetURL) {
            let request = URLRequest(url: url)
            webView.load(request)
            
        }
    }
    

    

}
