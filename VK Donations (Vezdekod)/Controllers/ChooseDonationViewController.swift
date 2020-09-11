//
//  ViewController.swift
//  VK Donations (Vezdekod)
//
//  Created by Alex Yatsenko on 11.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import UIKit

final class ChooseDonationViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueID.regularDonation,
            let newDonationVC = segue.destination as? NewDonationTableViewController {
            newDonationVC.regularAmountLabelText = Text.amountLabel
            newDonationVC.regularAmountPlaceholderText = Text.placeholder
            newDonationVC.title = Text.regularDonationTitle
        }
    }
}
