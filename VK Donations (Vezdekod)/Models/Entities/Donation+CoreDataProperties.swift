//
//  Donation+CoreDataProperties.swift
//  VK Donations (Vezdekod)
//
//  Created by Alex Yatsenko on 12.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//
//

import Foundation
import CoreData


extension Donation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Donation> {
        return NSFetchRequest<Donation>(entityName: "Donation")
    }

    @NSManaged public var decriptionText: String?
    @NSManaged public var image: Data?
    @NSManaged public var title: String?
    @NSManaged public var text: String?
    @NSManaged public var amount: String?
    @NSManaged public var target: String?

}
