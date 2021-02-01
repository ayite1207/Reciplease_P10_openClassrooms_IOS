//
//  String.swift
//  Reciplease
//
//  Created by ayite on 31/01/2021.
//

import Foundation


extension String {
    /**
     * Check if a string contains at least one element
     */
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespaces) == String() ? true : false
    }
}
