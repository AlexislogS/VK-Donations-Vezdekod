//
//  AdditionalTableViewController.swift
//  VK Donations (Vezdekod)
//
//  Created by Alex Yatsenko on 11.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import UIKit

final class AdditionalTableViewController: UITableViewController {
    
    @IBOutlet private weak var createButton: UIButton!
    @IBOutlet private weak var chooseDateButton: UIButton!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var whenCollectAmountButton: UIButton! {
        didSet {
            whenCollectAmountButton.setImage(#imageLiteral(resourceName: "radio_on_24"), for: .selected)
        }
    }
    @IBOutlet private weak var datePicker: UIDatePicker! {
        didSet {
            if let localeID = Locale.preferredLanguages.first {
                datePicker.locale = Locale(identifier: localeID)
            }
        }
    }
    @IBOutlet private weak var exactTimeButton: UIButton! {
        didSet {
            exactTimeButton.setImage(#imageLiteral(resourceName: "radio_on_24"), for: .selected)
            exactTimeButton.isSelected = true
        }
    }
    
    var donation: Donation?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueID.postSegue.rawValue,
            let postingVC = segue.destination as? PostingViewController {
            postingVC.donation = donation
        }
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction private func whenCollectAmountPressed() {
        whenCollectAmountButton.isSelected = true
        exactTimeButton.isSelected = false
        createButton.isEnabled = true
        chooseDateButton.setImage(UIImage(named: "Size Y_ Regular Default-1"), for: .normal)
        chooseDateButton.isEnabled = false
        dateLabel.isHidden = true
        if !datePicker.isHidden {
            datePicker.isHidden = true
        }
    }
    
    @IBAction private func exactTimePressed(_ sender: UIButton) {
        exactTimeButton.isSelected = true
        whenCollectAmountButton.isSelected = false
        createButton.isEnabled = false
        chooseDateButton.isEnabled = true
    }
    
    @IBAction private func chooseDatePressed() {
        datePicker.isHidden = datePicker.isHidden ? false : true
        dateLabel.isHidden = false
        dateLabel.text = datePicker.date.toString(format: "MMM d")
        chooseDateButton.setImage(UIImage(named: "Container-1"), for: .normal)
        createButton.isEnabled = true
    }
    
    @IBAction func DatePicked() {
        dateLabel.text = datePicker.date.toString(format: "MMM d")
    }
}

