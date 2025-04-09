//
//  ViewErrors.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 01.02.2025.
//

import UIKit

enum ViewErrors {
    
    var model: ViewErrorModel? {
        nil
    }
}

protocol ViewErrorModel {
    var title: String? { get }
    var message: String? { get }
    var image: UIImage? { get }
}
