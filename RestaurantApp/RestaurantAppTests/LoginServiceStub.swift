//
//  LoginServiceStub.swift
//  RestaurantAppTests
//
//  Created by Anderson Oliveira on 08/04/23.
//

import Foundation
@testable import RestaurantApp

final class LoginServiceStub: LoginServiceProtocol {
    
    private let isOnboardingSeen: Bool
    
    init(isOnboardingSeen: Bool) {
        self.isOnboardingSeen = isOnboardingSeen
    }
    
    func isUserOnboardingSeen() -> Bool {
        isOnboardingSeen
    }
    
    func setOnboardingSeen() { }
    
    func resetOnboardingSeen() { }
}
