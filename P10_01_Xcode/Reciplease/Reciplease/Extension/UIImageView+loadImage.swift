//
//  UIImageView+loadImage.swift
//  Reciplease
//
//  Created by ayite on 25/01/2021.
//

import Foundation
import UIKit

extension UIImageView{
    func load(url: URL){
        DispatchQueue.global().async {
            [weak self] in
            if let data = try? Data(contentsOf : url){
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
