//
//  DetailViewController.swift
//  SampleApp
//

import UIKit

class DetailViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableHeaderView: HeaderView!
    
    var currencies: [Currency]?
    var selectedCurrency: Currency?
    var currencyValues = [CurrencyValue]()
    var showFavourites = false
    
    var selectedDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchContent()
    }
    
    /// fetch the latest conversaion rates for the selected currency
    override func fetchContent() {
        if let selectedCurrency = selectedCurrency {
            tableHeaderView.codeLabel.text = selectedCurrency.code.uppercased()
            tableHeaderView.nameLabel.text = selectedCurrency.name
            
            APIHandler().fetchCurrencyValues(forBaseCurrency: selectedCurrency, forDate: selectedDate) { currencyValues, date, error in
                if let error = error {
                    self.showAlert(withTitle: error.localizedDescription, message: "Try again.")
                } else {
                    if let _currencyValues = currencyValues {
                        self.currencyValues = _currencyValues.sorted(by: { $0.code < $1.code })
                    } else {
                        self.showAlert(withTitle: "No currency conversions values available!", message: "Try again.")
                    }
                    if let date = date {
                        self.selectedDate = date
                        self.tableHeaderView.dateButton.setTitle(date.toString(), for: .normal)
                    } else {
                        self.tableHeaderView.dateButton.setTitle(Date().toString(), for: .normal)
                    }
                    self.tableView.tableHeaderView = self.tableHeaderView
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    /// Fetch the currency name from 'currencies array' using currency code
    private func currencyNameForCode(_ code: String) -> String {
        if let currencies = currencies {
            if let match = currencies.first(where: { currency in
                currency.code == code
            }) {
                return match.name
            }
        }
        return ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dateVC = segue.destination as? DateViewController {
            if let dateStr = tableHeaderView.dateButton.titleLabel?.text {
                Logger.debug("\(dateStr)")
                dateVC.selectedDate = Date.fromString(dateStr)
                dateVC.selectionBlock = { date in
                    self.selectedDate = date
                    self.fetchContent()
                }
            }
        }
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencyValues.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCellID") as! DetailsTableViewCell
        let value = currencyValues[indexPath.row]
        cell.codeLabel.text = value.code.uppercased()
        cell.valueLabel.text = "\(value.value)"
        if value.name.isEmpty {
            value.name = currencyNameForCode(value.code)
        }
        cell.nameLabel.text = value.name
        
        return cell
    }
}
