//
//  MockPlayersService.swift
//  CombineDemoTests
//
//  Created by Jazilul Athoya on 06/10/21.
//  Copyright © 2021 codeuqest. All rights reserved.
//

import Foundation
import Combine
@testable import CombineDemo

class MockPlayersService: PlayersServiceProtocol {
    
    var response: AnyPublisher<[Player], Error> = Future<[Player], Error> { promise in
        promise(.success([]))
    }.eraseToAnyPublisher()
        
    func get() -> AnyPublisher<[Player], Error> {
        return response
    }
}
