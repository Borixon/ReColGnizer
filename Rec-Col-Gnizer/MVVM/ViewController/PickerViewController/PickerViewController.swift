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
        view.layoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stupeAfterLayout()
    }
    
    private func stupeAfterLayout() {
        colorBackgroundView.layoutIfNeeded()
        colorBackgroundView.layer.masksToBounds = true
        colorBackgroundView.layer.cornerRadius = colorBackgroundView.frame.width / 2
    }
    
    private func setupViewComponents() {
        vm.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        colorBackgroundView.backgroundColor = vm.selectedColor
        checkDataButton.backgroundColor = .clear
        checkDataButton.tintColor = .clear
        checkDataButton.setTitleColor(.clear, for: .normal)
    }
    
    private func setupSearchBar() {
        searchBar.setShowsCancelButton(false, animated: false)
        searchBar.returnKeyType = .search
        searchBar.delegate = self
        searchBar.placeholder = vm.placeholder
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
        DispatchQueue.main.async {
            self.hideLoadingScreen()
            self.coordinator?.openColorData(data: ColorModel(color: color))
        }
    }
    
    func show(error: Error?) {
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


/* TODO Zbiorczy
 CD Zapis wszytkiego 
 CD Baza REMOVE!!!!!
 Modele - colory exact i derivative
 Kolory w aplikacji Tint - Styl?
 Layout głownego pickera
 Konwersja RGB-HLS
 Loading screen add / remove
 Kamera wyłączanie sesji
 Alerty: Zły hex, bład kolorów, brak kamery, inne catche
 Kamera dodanie flash
 
 Optionale
 Dodanie CMYK?
 Kamera naprawa pinch zoom
 
 Kolejny etam
 Schematy kolorów
 */

