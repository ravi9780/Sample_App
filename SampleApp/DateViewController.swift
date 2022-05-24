//
//  DateViewController.swift
//  SampleApp
//
//  Created by Mehul Bhavani on 22/05/22.
//

import UIKit

class DateViewController: UIViewController {
    
    @IBOutlet var datePicker: UIDatePicker!
    
    var selectedDate: Date?
    
    var selectionBlock: ((Date) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Logger.debug("\(String(describing: selectedDate))")
        
//        datePicker.maximumDate = Date()
        if let selectedDate = selectedDate {
            datePicker.setDate(selectedDate, animated: true) 
        }
    }
    @IBAction func doneButton_Tapped(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: {
            if let selectionBlock = self.selectionBlock {
                selectionBlock(self.datePicker.date)
            }
        })
    }
}
