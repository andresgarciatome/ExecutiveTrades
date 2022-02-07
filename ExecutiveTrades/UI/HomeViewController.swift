//
//  HomeViewController.swift
//  ExecutiveTrades
//
//  Created by Andrés García on 6/2/22.
//

import Foundation

import UIKit

class HomeViewController: GNBViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textTitle: UILabel!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    private let defaultSize = Sizes.cellDefault
    private let model = HomeViewModel()
    
    // MARK: lifeCycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        model.loadData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        self.configTableView()
        textTitle.titlePrimaryText()
    }
    
    func configTableView() {
        tableView.register(UINib(nibName: FileName.productCell, bundle: nil), forCellReuseIdentifier: CellID.product)
        tableView.delegate = self
        tableView.dataSource = self
        let bearGif = UIImage.gifImageWithName(FileName.gifLoading)
        let imageView = UIImageView(image: bearGif)
        tableView.backgroundView = imageView
    }
    
    // MARK: - DataSource and Delegate of TableView method's
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberRows = model.getNumProducts()
        if numberRows > 0 {
            tableViewHeight.constant = CGFloat(numberRows * defaultSize)
            tableView.backgroundView?.isHidden = true
        } else {
            tableView.backgroundView?.isHidden = false
            tableViewHeight.constant = CGFloat(Sizes.gifHeight)
        }
        return numberRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellID.product, for: indexPath) as? ProductCell {
            cell.configCell(model: model.getProducts(indexPath: indexPath))
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Save select product and go to the new VC
        model.setSelectedProduct(index: indexPath.row)
        ProductViewController.pushViewController(nvc: navigationController)
    }
}
