//
//  ListViewController.swift
//  SampleApp
//


import UIKit

class ListViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var currencies = [Currency]()

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
//            Logger.debug("\(currencies[indexPath.row])")
            if let detailVC = segue.destination as? DetailViewController {
                detailVC.selectedCurrency = currencies[indexPath.row]
                detailVC.currencies = currencies
            }
        }
    }
    
    override func fetchContent() {
        APIHandler().fetchAllCurrencies { currencies, error in
            if let error = error {
                self.showAlert(withTitle: error.localizedDescription, message: "Try again.")
            } else {
                if let _currencies = currencies {
                    self.currencies = _currencies.sorted(by: { $0.name < $1.name })
                    self.tableView.reloadData()
                } else {
                    self.showAlert(withTitle: "No currencies available!", message: "Try again.")
                }
            }
        }
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCellID") as! ListTableViewCell
        let currency = currencies[indexPath.row]
        cell.codeLabel.text = currency.code.uppercased()
        cell.nameLabel.text = currency.name
        
        return cell
    }
}

