//
//  Optional+Extension.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 09.04.2025.
//

import Foundation

extension Optional where Wrapped == String {
    
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}
