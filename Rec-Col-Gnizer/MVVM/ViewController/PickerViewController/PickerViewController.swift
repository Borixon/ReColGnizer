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
        let rgbButton = createButton(title: "RGB", selector: #selector(PickerViewModel.rgbPicked))
        let hslButton = createButton(title: "HSL", selector: #selector(PickerViewModel.hslPicked))
        categoryStackView.addArrangedSubview(rgbButton)
        categoryStackView.addArrangedSubview(hslButton)
    }
    
    func createButton(title: String, selector: Selector) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 9
        button.backgroundColor = .groupTableViewBackground
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle(title, for: .normal)
        button.addTarget(vm, action: selector, for: .touchUpInside)
        
        return button
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
