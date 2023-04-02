//
//  OnboardingItem.swift
//  FashionApp
//
//  Created by Anderson Oliveira on 02/04/23.
//


struct OnboardingItem {
    
    let author: String
    let quote: String
    
    static var quoteItems: [OnboardingItem] {
        [.init(author: "Ralph Lauren", quote: "I don't design clothes. I design dreams."),
         .init(author: "Yves Saint Laurent", quote: "Fashions fade, style is eternal."),
         .init(author: "Sonia Rykiel", quote: "How can you live the high life if you do not wear the high heels?"),
         .init(author: "Elsa Schiaparelli", quote: "In difficult times, fashion is always outrageous."),
        ]
    }
}


