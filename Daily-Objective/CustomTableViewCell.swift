//
//  CustomTableViewCell.swift
//  Daily-Objective
//
//  Created by Dan on 15.07.15.
//  Copyright (c) 2015 9volt. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var objectiveLabel: UILabel!
    @IBOutlet weak var completionLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
