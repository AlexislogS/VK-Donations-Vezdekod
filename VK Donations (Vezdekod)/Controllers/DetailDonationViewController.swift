//
//  DetailDonationViewController.swift
//  VK Donations (Vezdekod)
//
//  Created by Alex Yatsenko on 12.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import UIKit

final class DetailDonationViewController: UIViewController {
    
    @IBOutlet private weak var donationProgressView: UIProgressView!
    @IBOutlet private weak var donationImageView: UIImageView!
    @IBOutlet private weak var donationTextView: UITextView!
    @IBOutlet private weak var donationTitle: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var targetLabel: UILabel!
    
    var donation: Donation?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction private func helpButtonPressed(_ sender: UIButton) {
        donationProgressView.progress += 0.2
        if donationProgressView.progress == 1 {
            amountLabel.text = "Вся сумма собрана!"
            let animator = UIViewPropertyAnimator(duration: 0.7, dampingRatio: 0.4) {
                sender.transform = .init(scaleX: 0.9, y: 0.9)
            }
            animator.startAnimation()
        }
    }
    
    private func updateUI() {
        donationTitle.text = donation?.title
        donationTextView.text = donation?.text
        targetLabel.text = donation?.target
        amountLabel.text = donation?.amount
        if let imageData = donation?.image {
            donationImageView.image = UIImage(data: imageData)
        }
    }
}
