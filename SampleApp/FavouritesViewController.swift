//
//  FavouritesViewController.swift
//  SampleApp
//
//  Created by Mehul Bhavani on 23/05/22.
//

import UIKit

class FavouritesViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noDataLabel: UILabel!
    
    var favCurrencies = [Currency]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            //Logger.debug("\(currencies[indexPath.row])")
            if let detailVC = segue.destination as? DetailViewController {
                detailVC.selectedCurrency = favCurrencies[indexPath.row]
                detailVC.currencies = favCurrencies
                detailVC.showFavourites = true
            }
        }
    }
    
    override func fetchContent() {
        if let favs = UserDefaults.standard.dictionary(forKey: "kFavs") as? [String: String] {
            //favCurrencies = favs
            for (key, value) in favs {
                favCurrencies.append(Currency(code: key, name: value))
            }
            tableView.reloadData()
        }
        noDataLabel.isHidden = !favCurrencies.isEmpty
    }
}

extension FavouritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favCurrencies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCellID") as! ListTableViewCell
        let currency = favCurrencies[indexPath.row]
        cell.codeLabel.text = currency.code.uppercased()
        cell.nameLabel.text = currency.name
        
        return cell
    }
}
