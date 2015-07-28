//
//  Objective.swift
//  Daily-Objective
//
//  Created by Dan on 22.07.15.
//  Copyright (c) 2015 9volt. All rights reserved.
//

import Foundation
import CoreData

class Objective:NSManagedObject {
    @NSManaged var name:String!
    @NSManaged var image:NSData!
    @NSManaged var progress:String!
    @NSManaged var status:NSNumber!
    @NSManaged var quantity:String!
    
}