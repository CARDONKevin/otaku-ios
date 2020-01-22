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
    var savedListOfFilms: [FilmDataResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableFilms.reloadData()
    }
    
    func setup () {
        tableFilms.dataSource = self
        tableFilms.delegate = self
        tableFilms.rowHeight = UITableView.automaticDimension
        tableFilms.estimatedRowHeight = 80.0
        getFilms()
    }
    
    func getFilms(){
    AF.request("https://ghibliapi.herokuapp.com/films",method: .get) .responseDecodable { [weak self](response: DataResponse<[FilmDataResponse], AFError>) in
        switch response.result
        {
        case .success(let films):
            self?.listOfFilms = films
            self?.savedListOfFilms = films
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
    
    
    @IBAction func sortByScore(_ sender: Any) {
        self.listOfFilms = self.savedListOfFilms

        let isInAsc: Bool = UserDefaults.standard.bool(forKey: "sortByScore") ?? false
        
        if isInAsc {
            if listOfFilms.count > 0 {
                 self.listOfFilms = listOfFilms.sorted { Int($0.rtScore!)! >  Int($1.rtScore!)! }
                 tableFilms.dataSource = self
                 tableFilms.reloadData()
             }
        } else {
            if listOfFilms.count > 0 {
                      self.listOfFilms = listOfFilms.sorted { Int($0.rtScore!)! <  Int($1.rtScore!)! }
                      tableFilms.dataSource = self
                      tableFilms.reloadData()
                  }
        }
        
        UserDefaults.standard.set(!isInAsc, forKey: "sortByScore")
    }
    
    @IBAction func sortByName(_ sender: Any) {
        self.listOfFilms = self.savedListOfFilms

        let isInAsc: Bool = UserDefaults.standard.bool(forKey: "sortByName") ?? false
        
        if isInAsc {
            if listOfFilms.count > 0 {
                self.listOfFilms = listOfFilms.sorted { $0.title! >  $1.title! }
                tableFilms.dataSource = self
                tableFilms.reloadData()
            }
        } else {
            if listOfFilms.count > 0 {
                self.listOfFilms = listOfFilms.sorted { $0.title! <  $1.title! }
                tableFilms.dataSource = self
                tableFilms.reloadData()
            }
        }
        
        UserDefaults.standard.set(!isInAsc, forKey: "sortByName")

    }
    
    
    @IBAction func sortByDate(_ sender: Any) {
        self.listOfFilms = self.savedListOfFilms

        let isInAsc: Bool = UserDefaults.standard.bool(forKey: "sortByDate") ?? false
        
        if isInAsc {
            if listOfFilms.count > 0 {
                self.listOfFilms = listOfFilms.sorted { Int($0.releaseDate!)! >  Int($1.releaseDate!)! }
                tableFilms.dataSource = self
                tableFilms.reloadData()
            }
        } else {
            if listOfFilms.count > 0 {
                self.listOfFilms = listOfFilms.sorted { Int($0.releaseDate!)! <  Int($1.releaseDate!)! }
                tableFilms.dataSource = self
                tableFilms.reloadData()
            }
        }
        
        UserDefaults.standard.set(!isInAsc, forKey: "sortByDate")
    }
    
    
    @IBAction func filterLovedOrNo(_ sender: Any) {
        
        self.listOfFilms = self.savedListOfFilms
        
        var index: Int = -1
        
        let loved: Bool = UserDefaults.standard.bool(forKey: "loved") ?? false
        
        if loved {
            for element in listOfFilms {
                index = index + 1
                var isLoved: Bool = UserDefaults.standard.bool(forKey: element.id!) ?? false
                
                if isLoved {
                    listOfFilms.remove(at: index)
                    index = index - 1
                }
                
            }
        } else {
            for element in listOfFilms {
                index = index + 1
                var isLoved: Bool = UserDefaults.standard.bool(forKey: element.id!) ?? false
                
                if !isLoved {
                    listOfFilms.remove(at: index)
                    index = index - 1
                }
                
            }
        }
        
        tableFilms.dataSource = self
        tableFilms.reloadData()
        
        UserDefaults.standard.set(!loved, forKey: "loved")
        
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //AVEC LES SEGUE
        selectedFilm = listOfFilms[indexPath.row]
        self.performSegue(withIdentifier: "showDetailFromList", sender: nil)
    }
    //func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      //  return 80.0
    //}
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

