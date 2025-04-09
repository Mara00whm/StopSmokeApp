//
//  HomeNetworkModel.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 06.04.2025.
//

import Foundation

enum HomeNetworkModel {
    
    struct CigarettesDto: Decodable {
        let cigarettes: [CigaretteDto]
    }

    struct CigaretteDto: Decodable {
        let date: Date
    }
}
