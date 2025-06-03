//
//  SporaAppTests.swift
//  SporaAppTests
//
//  Created by macOS on 27/05/2025.
//

import XCTest
@testable import SporaApp

final class SporaAppTests: XCTestCase {

    var networkService : NetworkServiceProtocol!
    
    override func setUpWithError() throws {
        networkService = NetworkService()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        networkService = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTennisPlayers(){
        let exp = expectation(description: "waiting for network..")
        networkService.getTennisPlayers { result in
            if result.result.isEmpty{
                XCTFail()
            }else{
                XCTAssert(result.result.count == 974)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    
    func testTennisPlayersByLeagueId(){
        let exp = expectation(description: "waiting for network..")
        networkService.getTennisPlayersByLeaguesID(leagueID: 3173) { result in
            if result.result.isEmpty{
                XCTFail()
            }else{
                XCTAssertNotNil(result.result)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testGetTeams(){
        let exp = expectation(description: "waiting for network..")
        networkService.getTeams(sportName: "football", leagueID: 4) { result in
            if result.result.isEmpty{
                XCTFail()
            }else{
                XCTAssert(result.result.count == 70)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    func testGetLeagues(){
        let exp = expectation(description: "waiting for network..")
        networkService.getLeagues(sport: "football"){ result in
            if result.result.isEmpty{
                XCTFail()
            }else{
                XCTAssertNotNil(result.result)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testGetFixures(){
        let exp = expectation(description: "waiting for network..")
        networkService.getFixtures(sportName: "football", leagueId: 4) { result in
            if result.isEmpty{
                XCTFail()
            }else{
                XCTAssertNotNil(result)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
