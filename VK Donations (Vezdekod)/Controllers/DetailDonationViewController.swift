//
//  DetailDonationViewController.swift
//  VK Donations (Vezdekod)
//
//  Created by Alex Yatsenko on 12.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import UIKit

final class DetailDonationViewController: UIViewController {
    
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var donationProgressView: UIProgressView!
    @IBOutlet private weak var donationImageView: UIImageView!
    @IBOutlet private weak var donationTextView: UITextView!
    @IBOutlet private weak var donationTitle: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var targetLabel: UILabel!
  
    private let trackLayer = CAShapeLayer()
    private let ratingLayer = CAShapeLayer()
    
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
      let animation = CABasicAnimation(keyPath: "strokeEnd")
      animation.toValue = 1
      animation.duration = 2
      animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
      animation.fillMode = .backwards
      animation.isRemovedOnCompletion = false
      ratingLayer.add(animation, forKey: "rating")
    }
    
    private func updateUI() {
        donationTitle.text = donation?.title
        donationTextView.text = donation?.text
        targetLabel.text = donation?.target
        amountLabel.text = donation?.amount
        if let imageData = donation?.image {
            donationImageView.image = UIImage(data: imageData)
        }
        updateRatingLayer()
    }
  
  private func updateRatingLayer() {
    let trackPath = UIBezierPath(
      roundedRect: CGRect(x: 0,
                          y: -5,
                          width: ratingLabel.bounds.width,
                          height: ratingLabel.bounds.height + 10),
      cornerRadius: 20
    )
    trackLayer.path = trackPath.cgPath
    trackLayer.lineWidth = trackPath.bounds.height
    trackLayer.fillColor = UIColor(red: 184/255,
                                   green: 193/255,
                                   blue: 204/255,
                                   alpha: 0.4).cgColor
    ratingLabel.layer.addSublayer(trackLayer)
    
    let ratingPath = UIBezierPath()
    ratingPath.move(to: CGPoint(x: 0,
                                y: trackLayer.bounds.minY + 10))
    ratingPath.addLine(to: CGPoint(x: ratingLabel.bounds.maxX,
                                   y: trackLayer.bounds.minY + 10))
    ratingLayer.path = ratingPath.cgPath
    ratingLayer.lineCap = .round
    ratingLayer.strokeEnd = 0
    ratingLayer.strokeColor = UIColor(red: 75/255,
                                      green: 179/255,
                                      blue: 75/255,
                                      alpha: 1).cgColor
    ratingLayer.lineWidth = trackPath.bounds.height
    ratingLabel.layer.addSublayer(ratingLayer)
  }
}
