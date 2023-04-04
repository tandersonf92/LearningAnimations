//
//  OnboardingItem.swift
//  FashionApp
//
//  Created by Anderson Oliveira on 02/04/23.
//

import UIKit


struct OnboardingItem {
    
    let author: String
    let quote: String
    let image: UIImage?
    
    static var quoteItems: [OnboardingItem] {
        [.init(author: "Ralph Lauren",
               quote: "I don't design clothes. I design dreams.",
               image: UIImage(named: "imFashion1")),
         .init(author: "Yves Saint Laurent",
               quote: "Fashions fade, style is eternal.",
               image: UIImage(named: "imFashion2")),
         .init(author: "Sonia Rykiel",
               quote: "How can you live the high life if you do not wear the high heels?",
               image: UIImage(named: "imFashion3")),
         .init(author: "Elsa Schiaparelli",
               quote: "In difficult times, fashion is always outrageous.",
               image: UIImage(named: "imFashion4")),
        ]
    }
}


