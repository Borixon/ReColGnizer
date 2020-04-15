//
//  RGBViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class RGBViewController: BaseViewController, Storyboarded {
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var colorSpace: UIView!
    @IBOutlet weak var redField: UITextField!
    @IBOutlet weak var greenField: UITextField!
    @IBOutlet weak var blueField: UITextField!
     
    var coordinator: MainCoordinator?
    internal let vm = RGBViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingCoordinator()
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
    
    private func setupLoadingCoordinator() {
//        if let nav = coordinator?.navigationController {
//            loadingCoordinator = LoadingCoordinator(withNavigationController: nav)
//        }
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
        checkButton.layer.cornerRadius = Styles.applyButtonCornerRadius
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
        vm.downloadRGBData(completion: { model, error in
            DispatchQueue.main.async {
                if model != nil {
                    self.coordinator?.openColorData(data: model!)
                } else {
                    print(error)
                }
            }
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
 
