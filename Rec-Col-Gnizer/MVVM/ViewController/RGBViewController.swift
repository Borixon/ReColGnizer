//
//  RGBViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class RGBViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var colorSpace: UIView!
    @IBOutlet weak var redField: UITextField!
    @IBOutlet weak var greenField: UITextField!
    @IBOutlet weak var blueField: UITextField!
     
    public weak var coordinator: MainCoordinator?
    internal let vm = RGBViewModel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSliders()
        setupViewModel()
        setupViewComponents()
        setupTapRecognizer()
        setupTextFields()
    }
    
    private func setupTapRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    deinit {
        print("DEINITIALIZE VC \(String(describing: self))")
    }
    
    private func setupTextFields() {
        redField.delegate = self
        greenField.delegate = self
        blueField.delegate = self
        
        redField.text = String(vm.colorData.red)
        greenField.text = String(vm.colorData.green)
        blueField.text = String(vm.colorData.blue)
        
        redField.layer.borderWidth = 0
        blueField.layer.borderWidth = 0
        greenField.layer.borderWidth = 0
    }
    
    private func setupViewComponents() {
        view.backgroundColor = vm.mainColor
        
        checkButton.tintColor = vm.mainColor
        checkButton.layer.cornerRadius = 15
        checkButton.layer.masksToBounds = true
        
        colorSpace.backgroundColor = vm.getSelectedColor()
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = vm.mainColor
    }
    
    private func setupSliders() {
        redSlider.maximumValue = Float(RGBModel.maxRGB)
        greenSlider.maximumValue = Float(RGBModel.maxRGB)
        blueSlider.maximumValue = Float(RGBModel.maxRGB)
        
        redSlider.minimumValue = Float(RGBModel.minRGB)
        greenSlider.minimumValue = Float(RGBModel.minRGB)
        blueSlider.minimumValue = Float(RGBModel.minRGB)
        
        redSlider.value = vm.selectedRed
        greenSlider.value = vm.selectedGreen
        blueSlider.value = vm.selectedBlue
    }
    
    private func setupViewModel() {
        vm.delegate = self
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
        
    }
    
    @IBAction func checkData(_ sender: Any) {
        let loadingVC = LoginViewController().instantiet()
        self.view.addSubview(loadingVC.view)
        addChild(loadingVC)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 1), execute: {
            loadingVC.removeFromParent()
        })
        
        WebService().getColorFrom(data: vm.colorData, completion: { model, error in
            print(model, error)
        })
    }
    
    @IBAction func valueChanged(_ sender: UISlider) {
        let value = sender.value
        let text = String(Int(value))
        if sender == redSlider {
            redField.text = text
            vm.selectedRed = value
        } else if sender == greenSlider {
            greenField.text = text
            vm.selectedGreen = value
        } else if sender == blueSlider {
            blueField.text = text
            vm.selectedBlue = value
        }
    }
}

extension RGBViewController: RGBViewModelDelegate {
    func colorSet(color: UIColor) {
        colorSpace.backgroundColor = vm.getSelectedColor()
    }
}

class LoginViewController {
    func instantiet() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if #available(iOS 13.0, *) {
            return storyboard.instantiateViewController(identifier: "LoadingViewController")
        } else {
            return storyboard.instantiateViewController(withIdentifier: "LoadingViewController")
        }
    }
     
}
