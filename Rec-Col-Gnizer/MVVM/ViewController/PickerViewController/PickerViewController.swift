//
//  ManualColorGetterViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, Storyboarded {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var textFieldsStack: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkDataButton: UIButton!
    @IBOutlet weak var colorBackgroundView: UIView!
    
    var coordinator: MainCoordinator?
    let vm = PickerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        setupViewComponents()
    }
    
    private func setupViewComponents() {
        vm.delegate = self
        colorBackgroundView.backgroundColor = vm.selectedColor
        checkDataButton.backgroundColor = .groupTableViewBackground
        checkDataButton.tintColor = .darkGray
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
        // TODO: Insert loading screen
        vm.sendDataRequest()
    }
    
    private func setupCategoryStack() {
        
    }
}

extension PickerViewController: PickerViewModelDelegate {
    func show(color: WSColorModel) {
        // TODO: Remove loading screen -> INSIDE OPEN COLOR???
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
