//
//  PinViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 11/05/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class PinViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    var viewSize: CGSize {
        return CGSize(width: widthConstraint.constant, height: heightConstraint.constant)
    }
    
    init() {
        super.init(nibName: "PinViewController", bundle: Bundle.main)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.masksToBounds = true
        colorView.layer.cornerRadius = colorView.bounds.width / 2.0
    }
    
    public func setColor(_ color: UIColor?) {
        colorView.backgroundColor = color
    }
    
}
