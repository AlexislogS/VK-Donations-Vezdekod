//
//  DonationCell.swift
//  VK Donations (Vezdekod)
//
//  Created by Alex Yatsenko on 12.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import UIKit

final class DonationCell: UITableViewCell {

    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var donationImageView: UIImageView!
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var amountLabel: UILabel!
    
    func configure(donation: Donation) {
        titleLabel.text = donation.title
        descriptionLabel.text = UserDefaults.standard.value(forKey: donation.title!) as? String
        if let imageData = donation.image {
            donationImageView.image = UIImage(data: imageData)
        }
    }
    
    @IBAction func helpButtonPressed(_ sender: UIButton) {
        progressView.progress += 0.2
        if progressView.progress == 1 {
            sender.setImage(#imageLiteral(resourceName: "Style 6_ Commerce"), for: .normal)
            progressView.tintColor = UIColor(red: 75/255, green: 179/255, blue: 75/255, alpha: 1)
            amountLabel.text = "Вся сумма собрана!"
            let animator = UIViewPropertyAnimator(duration: 0.7, dampingRatio: 0.4) {
                self.transform = .init(scaleX: 0.9, y: 0.9)
            }
            animator.startAnimation()
        }
    }
}
