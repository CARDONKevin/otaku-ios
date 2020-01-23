//
//  DetailsViewController.swift
//  Otaku-ios
//
//  Created by etudiant on 21/01/2020.
//  Copyright © 2020 etudiant. All rights reserved.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController {
    
    var idFilm: String?
    var isFavorite: Bool?
    
    @IBOutlet weak var bt_favoris: UIButton!
    @IBOutlet weak var image_film: UIImageView!
    @IBOutlet weak var label_rtScore: UILabel!
    @IBOutlet weak var label_releaseDate: UILabel!
    @IBOutlet weak var label_producer: UILabel!
    @IBOutlet weak var label_description: UILabel!
    @IBOutlet weak var label_title: UILabel!
    
    @IBOutlet weak var label_director: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        getFilm()
        changeButtonStatus()
    }
    
    func changeButtonStatus() {
        if let id = idFilm {
            isFavorite = UserDefaults.standard.bool(forKey: id)
            
            if let choice = isFavorite {
                if choice {
                    bt_favoris.setImage(UIImage(named: "favorite"), for: .normal)
                    
                }else {
                    bt_favoris.setImage(UIImage(named: "notFavorite"), for: .normal)
                    
                }
            }
        }
    }
    
    func getFilm() {
        if let id = idFilm {
            AF.request("https://ghibliapi.herokuapp.com/films/\(id)",method: .get) .responseDecodable { [weak self] (response: DataResponse<FilmDataResponse, AFError>) in
                switch response.result
                {
                case .success(let film):
                    self?.fillFilmData(film: film)
                    
                //
                case .failure(let error):
                    print(error.errorDescription ?? "")
                }
            }
        }
    }
    
    func fillFilmData(film: FilmDataResponse) {
        if let id = idFilm {
            
            self.image_film.image = UIImage(named: id)
        }
        self.label_title.text = film.title
        self.label_description.text = "Description :  \(film.myDataDescription!)"
        self.label_producer.text = "Producer : \(film.producer!)"
        self.label_director.text = "Director : \(film.director!)"
        self.label_releaseDate.text = "Release date :  \(film.releaseDate!)"
        self.label_rtScore.text = "score : \(film.rtScore!)/100"
        
        
    }
    
    
    @IBAction func addOrDeleteFavorite(_ sender: Any) {
        
        if let id = idFilm {
            let status: Bool = UserDefaults.standard.bool(forKey: id)
            UserDefaults.standard.set(!status, forKey: id)
            
            changeButtonStatus()
        }
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
