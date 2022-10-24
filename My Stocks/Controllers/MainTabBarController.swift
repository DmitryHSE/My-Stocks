//
//  MainTabBarController.swift
//  My Stocks
//
//  Created by Dmitry on 18.10.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // set viewcontrollers
    
    private var StocksVC: StocksViewController = StocksViewController.loadFromStoryboard()
    private var FavoriteVC: FavoriteViewController = FavoriteViewController.loadFromStoryboard()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAndNavBar()
        viewControllers = [configureViewController(VC: StocksVC, image: "dollarsign.circle", name: "Stocks"),
        configureViewController(VC: FavoriteVC, image: "star", name: "Favorite")]
    }
}



//MARK: - Extensions for current controller

extension MainTabBarController {
    
    private func configureViewController(VC: UIViewController,
                                        image: String,
                                        name: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: VC)
        navigationVC.tabBarItem.image = UIImage(systemName: image)
        navigationVC.tabBarItem.title = name
        VC.navigationItem.title = name
        navigationVC.navigationBar.prefersLargeTitles = true
        return navigationVC
        
        
    }
    
    
    private func setupTabBarAndNavBar() {
        
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithDefaultBackground()
            //navigationBarAppearance.backgroundColor = .white
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
        
        if #available(iOS 15.0, *) {
                    let tabBarAppearance = UITabBarAppearance()
                    tabBarAppearance.configureWithDefaultBackground()
                    //tabBarAppearance.backgroundColor = .white
                    UITabBar.appearance().standardAppearance = tabBarAppearance
                    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance

                }
    }
}
