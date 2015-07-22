//
//  Objective.swift
//  Daily-Objective
//
//  Created by Dan on 22.07.15.
//  Copyright (c) 2015 9volt. All rights reserved.
//

import Foundation

class Objective {
    var name:String = ""
    var icon:String = ""
    var progress:Float = 0
    var status:Bool = false
    
    init(name:String, icon:String, progress:Float, status:Bool) {
        self.name = name
        self.icon = icon
        self.progress = progress
        self.status = status
    }
    
}