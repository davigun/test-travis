//
//  CombineDemoTests.swift
//  CombineDemoTests
//
//  Created by Michal Cichecki on 04/07/2019.
//

@testable import CombineDemo
import XCTest
import Combine

class LoginViewModelTests: XCTestCase {

    private var subject: ListViewModel!
    private var cancellables: Set<AnyCancellable> = []
    private var mockPlayerService: MockPlayersService!
    
    override func setUp() {
        super.setUp()
        mockPlayerService = MockPlayersService()
        subject = ListViewModel(playersService: mockPlayerService)
    }
    
    override func tearDown() {
        cancellables.forEach { $0.cancel() }
        subject = nil
        
        super.tearDown()
    }
    
    func test_loadingStateWorking(){
        //condition
        mockPlayerService.response = Future<[Player], Error> { promise in
            promise(.success([]))
        }
        .delay(for: 10.0, scheduler: RunLoop.current)
        .eraseToAnyPublisher()
        
        subject.fetchPlayers()
        let exp = expectation(description: "Fetch Data for 5 seconds")
        XCTWaiter.wait(for: [exp], timeout: 5.0)
         
        //Given
        let expected: ListViewModelState = .error
        
        //Output
        XCTAssertEqual(expected, subject.state)
    }
    
    func test_finishedloadingStateWorking(){
        //condition
        mockPlayerService.response = Future<[Player], Error> { promise in
            promise(.success([]))
        }
        .delay(for: 4.0, scheduler: RunLoop.current)
        .eraseToAnyPublisher()
        
        subject.fetchPlayers()
        let exp = expectation(description: "Fetch Data for 5 seconds")
        XCTWaiter.wait(for: [exp], timeout: 5.0)
         
        //Given
        let expected: ListViewModelState = .finishedLoading
        
        //Output
        XCTAssertEqual(expected, subject.state)
    }
  
}

