//
//  VotingModel.swift
//  InstagramApp
//
//  Created by Natalia on 29.05.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import Foundation

struct VotingModel {
    var title: String?
    var voted: Int?
    var options: [(title: String, count: Int)]
}
