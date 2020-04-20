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
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkDataButton: UIButton!
    @IBOutlet weak var colorBackgroundView: UIView!
    
    let vm = PickerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        setupViewComponents()
        setupSegmentedControl()
    }
    
    private func setupViewComponents() {
        vm.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        colorBackgroundView.backgroundColor = vm.selectedColor
        checkDataButton.backgroundColor = .clear
        checkDataButton.tintColor = .clear
        checkDataButton.setTitleColor(.clear, for: .normal)
        colorBackgroundView.layer.masksToBounds = true
        colorBackgroundView.layer.cornerRadius = colorBackgroundView.frame.width / 2
        
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
    
    private func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        for i in 0...(vm.segmentedItems.count - 1) {
            segmentedControl.insertSegment(withTitle: vm.segmentedItems[i], at: i, animated: false)
        }
        segmentedControl.selectedSegmentIndex = vm.indexOfSelectedPicker
    }
    
    @IBAction func selectSegment(_ sender: UISegmentedControl) {
        vm.segmentSelected(index: sender.selectedSegmentIndex)
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
        coordinator?.openColorData(data: ColorModel(color: color))
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
