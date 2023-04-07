//
//  Slide.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import UIKit


struct Slide {
    let title: String
    let animationName: String
    let buttonTitle: String
    let buttonColor: UIColor
    
    static let collection: [Slide] = [
        .init(title: "Get your favorite food delivered to you under 30 minutes anytime",
              animationName: "",
              buttonTitle: "Next",
              buttonColor: .systemYellow),
        .init(title: "We serve only from choiced restaurants in your area",
              animationName: "",
              buttonTitle: "Order Now",
              buttonColor: .systemGreen)
    ]
}
