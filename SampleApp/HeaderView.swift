//
//  HeaderView.swift
//  SampleApp
//

import UIKit

class HeaderView: UIView {
    
    @IBOutlet var codeLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateButton: UIButton!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
