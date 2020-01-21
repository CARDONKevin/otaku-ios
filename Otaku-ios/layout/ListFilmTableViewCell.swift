//
//  listFilmTableViewCell.swift
//  Otaku-ios
//
//  Created by etudiant on 21/01/2020.
//  Copyright © 2020 etudiant. All rights reserved.
//

import UIKit

class ListFilmTableViewCell: UITableViewCell {

    @IBOutlet weak var score_label: UILabel!
    @IBOutlet weak var title_label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
        
        
        }        // Configure the view for the selected state

    
    
    //Public Functions
    func fill(withFilmDataResponse film: FilmDataResponse) {
        title_label.text = film.title
        score_label.text = film.rtScore
    }


}
