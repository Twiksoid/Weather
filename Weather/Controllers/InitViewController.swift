//
//  InitViewController.swift
//  Weather
//
//  Created by Nikita Byzov on 09.12.2022.
//

import UIKit

class InitViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var viewControllerForShowing: UIViewController
        
        if (UserDefaults.standard.value(forKey: "onboarding") as? String) == nil {
            viewControllerForShowing = PermissionLocationController()
            pushViewController(viewControllerForShowing, animated: true)
        } else {
            viewControllerForShowing = PageViewController()
            pushViewController(viewControllerForShowing, animated: true)
        }
        
        
       // pushViewController(viewControllerForShowing, animated: true)
//        view.window?.rootViewController = viewControllerForShowing
//        view.window?.makeKeyAndVisible()
    }

}
