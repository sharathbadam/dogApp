//
//  StartVC.swift
//  dogApp
//
//  Coding Exercise:
//  Display ListVC when the app page is swiped
//

import UIKit

class StartVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure a swipe gesture recognizer to trigger navigation to the ListVC
        let pushSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(showListVC))
        pushSwipeGesture.direction = .left
        view.addGestureRecognizer(pushSwipeGesture)
        
    }

    
    @IBAction func beginTouch(_ sender: Any) {
        showListVC()
    }
    
    // Method to navigate to the ListVC when triggered
    @objc
    private func showListVC() {
        let listVC = ListVC()
        self.show(listVC, sender: self)
    }
}
