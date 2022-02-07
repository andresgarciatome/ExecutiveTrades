//
//  ViewController.swift
//  ExecutiveTrades
//
//  Created by Andrés García on 4/2/22.
//

import UIKit

class GNBViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomNavigationBar()
    }
    
    //Set custom navigationBar
    func setCustomNavigationBar() {
        let image = UIImage(named: AssetName.GNB)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        navigationController?.navigationBar.barTintColor  =
        UIColor.init(named: Color.header)
        navigationController?.navigationBar.backgroundColor  = UIColor.init(named: Color.header)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    

}

