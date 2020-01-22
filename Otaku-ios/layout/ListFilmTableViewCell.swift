//
//  listFilmTableViewCell.swift
//  Otaku-ios
//
//  Created by etudiant on 21/01/2020.
//  Copyright © 2020 etudiant. All rights reserved.
//

import UIKit

class ListFilmTableViewCell: UITableViewCell {
    var isFavorite: Bool?
    var film: FilmDataResponse?

    
    
    @IBOutlet weak var image_film: UIImageView!
    @IBOutlet weak var bt_favorite: UIButton!
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
        if let id = film.id {
            image_film.image = UIImage(named: id)
        }
        
        title_label.text = film.title 
        score_label.text = "score : \(film.rtScore!)/100"
        changeButtonStatus(film: film)
    }
    
    func changeButtonStatus(film: FilmDataResponse?) {
        if let id = film?.id {
            self.film = film
          isFavorite = UserDefaults.standard.bool(forKey: id) ?? false
            
            if let choice = isFavorite {
                if choice {
                    bt_favorite.setImage(UIImage(named: "favorite"), for: .normal)
                    
                }else {
                    bt_favorite.setImage(UIImage(named: "notFavorite"), for: .normal)
                        
                }
            }
        }
    }
    
    @IBAction func addOrDeleteFavorite(_ sender: Any) {
        if let id = film?.id {
            
            let status: Bool = UserDefaults.standard.bool(forKey: id) ?? false
            UserDefaults.standard.set(!status, forKey: id)
            
            changeButtonStatus(film: film)
        }
    }
}
