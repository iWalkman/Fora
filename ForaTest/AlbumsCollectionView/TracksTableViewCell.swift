//
//  TracksTableViewCell.swift
//  
//
//  Created by Konstantin Fomin on 28/11/2018.
//

import UIKit

class TracksTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameThrackLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initialize(track: Track){
        self.numberLabel.text = track.number
        self.nameThrackLabel.text = track.name
    }

}
