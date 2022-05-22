//
//  BaseViewController.swift
//  SampleApp
//

import UIKit

class BaseViewController: UIViewController {
    
//    let activityView = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshBarButton_Tapped(_:)))
        self.navigationItem.setRightBarButton(refreshBarButtonItem, animated: false)
    }
    
    final func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc final func refreshBarButton_Tapped(_ sender: UIBarButtonItem) {
        fetchContent()
    }
    
    func fetchContent() {
        // override in subclass
    }
}
