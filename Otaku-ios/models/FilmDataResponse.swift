//
//  FilmDataResponse.swift
//  Otaku-ios
//
//  Created by etudiant on 21/01/2020.
//  Copyright © 2020 etudiant. All rights reserved.
//

import UIKit

class FilmDataResponse: Codable {
    var id, title, myDataDescription, director: String?
    var producer, releaseDate, rtScore: String?
    var people, species, locations, vehicles: [String]?
    var url: String?
    var length: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case myDataDescription = "description"
        case director, producer
        case releaseDate = "release_date"
        case rtScore = "rt_score"
        case people, species, locations, vehicles, url, length
    }

    init(id: String?, title: String?, myDataDescription: String?, director: String?, producer: String?, releaseDate: String?, rtScore: String?, people: [String]?, species: [String]?, locations: [String]?, vehicles: [String]?, url: String?, length: String?) {
        self.id = id
        self.title = title
        self.myDataDescription = myDataDescription
        self.director = director
        self.producer = producer
        self.releaseDate = releaseDate
        self.rtScore = rtScore
        self.people = people
        self.species = species
        self.locations = locations
        self.vehicles = vehicles
        self.url = url
        self.length = length
    }

}
