//
//  ViewController.swift
//  Otaku-ios
//
//  Created by etudiant on 21/01/2020.
//  Copyright © 2020 etudiant. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var selectedFilm: FilmDataResponse?

    @IBOutlet weak var tableFilms: UITableView!
    
    var listOfFilms: [FilmDataResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup () {
        tableFilms.dataSource = self
        tableFilms.delegate = self
        getFilms()
    }
    
    func getFilms(){
    AF.request("https://ghibliapi.herokuapp.com/films",method: .get) .responseDecodable { [weak self](response: DataResponse<[FilmDataResponse], AFError>) in
        switch response.result
        {
        case .success(let films):
            self?.listOfFilms = films
            self?.tableFilms.reloadData()
            
            //
        case .failure(let error):
            print(error.errorDescription ?? "")
        }
    }
    }
    
    override func prepare(for segue:
        UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailFromList" {
            let detailVC = segue.destination as? DetailsViewController
            detailVC?.idFilm = selectedFilm?.id
        }
    }

}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //AVEC LES SEGUE
        selectedFilm = listOfFilms[indexPath.row]
        self.performSegue(withIdentifier: "showDetailFromList", sender: nil)
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfFilms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if let cellDynamique = tableView.dequeueReusableCell(withIdentifier: "FilmCellID", for: indexPath) as? ListFilmTableViewCell {
            
            let correctFilm = listOfFilms[indexPath.row]
            cellDynamique.fill(withFilmDataResponse: correctFilm)
            
            return cellDynamique
        }else {
            return UITableViewCell()
        }
    }
    
    
}

