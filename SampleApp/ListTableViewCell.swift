//
//  ListTableViewCell.swift
//  SampleApp
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet var codeLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
