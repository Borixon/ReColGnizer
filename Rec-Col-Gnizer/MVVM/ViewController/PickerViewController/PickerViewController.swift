//
//  ManualColorGetterViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class PickerViewController: BaseViewController, Storyboarded {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkDataButton: UIButton!
    @IBOutlet weak var colorBackgroundView: UIView!
    
    let vm = PickerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        setupViewComponents()
        setupCategoryStack()
    }
    
    private func setupViewComponents() {
        vm.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        colorBackgroundView.backgroundColor = vm.selectedColor
        checkDataButton.backgroundColor = .groupTableViewBackground
        checkDataButton.tintColor = .darkGray
        checkDataButton.layer.cornerRadius = 15
        checkDataButton.layer.masksToBounds = true
        checkDataButton.setTitleColor(.darkGray, for: .normal)
        colorBackgroundView.layer.masksToBounds = true
        colorBackgroundView.layer.cornerRadius = 15 // TODO: Przenieśc do jakiegos stylu czy cos
        
    }
    
    private func setupSearchBar() {
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.returnKeyType = .search
        searchBar.delegate = self
        searchBar.placeholder = "AC12F3, f3c"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = vm.rowHeight
        tableView.register(UINib(nibName: "SliderCell", bundle: Bundle.main), forCellReuseIdentifier: vm.sliderCellIdentifier)
    }
    
    @IBAction func checkData(_ sender: Any) {
        openLoadingScreen()
        vm.sendDataRequest()
    }
    
    private func setupCategoryStack() {
        // TODO : Remove from here
        let rgbButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        rgbButton.layer.masksToBounds = true
        rgbButton.layer.cornerRadius = 9
        rgbButton.backgroundColor = .groupTableViewBackground
        rgbButton.setTitleColor(.darkGray, for: .normal)
        rgbButton.setTitle("RGB", for: .normal)
        rgbButton.addTarget(vm, action: #selector(PickerViewModel.rgbPicked), for: .touchUpInside)
        
        let hslButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        hslButton.layer.masksToBounds = true
        hslButton.layer.cornerRadius = 9
        hslButton.backgroundColor = .groupTableViewBackground
        hslButton.setTitleColor(.darkGray, for: .normal)
        hslButton.setTitle("HSL", for: .normal)
        hslButton.addTarget(vm, action: #selector(PickerViewModel.hslPicked), for: .touchUpInside)
        
        categoryStackView.addArrangedSubview(rgbButton)
        categoryStackView.addArrangedSubview(hslButton)
    }
    
    @objc internal func hideKeyboard() {
        searchBar.setShowsCancelButton(false, animated: true)
        view.endEditing(true)
    }
    
    internal func revelKeyboard() {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}

extension PickerViewController: PickerViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
    
    func show(color: WSColorModel) {
        hideLoadingScreen()
        coordinator?.openColorData(data: color)
    }
    
    func show(error: Error?) {
        // TODO: Remove loading screen
        coordinator?.show(error: error)
    }
    
    func didPick(color: UIColor) {
        colorBackgroundView.backgroundColor = color
    }
}

extension PickerViewController: SliderCellDelegate {
    func didChange(value: Float, type: SliderCellType) {
        vm.sliderDataChange(value, type: type)
    }
}
