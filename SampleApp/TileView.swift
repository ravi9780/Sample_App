//
//  TileView.swift
//  SampleApp
//

import UIKit

class TileView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat  = 3.0
    @IBInspectable var shadowColor: UIColor = UIColor.lightGray
    @IBInspectable var shadowOpacity: Float = 1.0
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 1.0)
    @IBInspectable var shadowRadius: CGFloat = 1.0

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
    }

}
