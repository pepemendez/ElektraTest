//
//  SeriesTests.swift
//  SeriesTests
//
//  Created by Jose Mendez on 22/10/21.
//

import XCTest
@testable import Series

class SeriesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //We wanted to know if all videos came from Youtube, Short answer: NO
    /*func testVideoMoviePlaying() throws {
        let model = ViewModelList()
        let expectation = self.expectation(description: "Waiting to fetch")
        expectation.expectedFulfillmentCount = 500
        expectation.assertForOverFulfill = false
        model.retreiveDataList(type: .MoviePlaying)
        for _ in 1...49 {
            model.retreiveMoreDataList(type: .MoviePlaying)
        }
        
        var currentCount = 0
        var totalCount = 0
        var totalvideos = [Video]()
        
        model.refreshData = {
            _ in
            expectation.fulfill()
            
            currentCount = currentCount + 1
            
            if(currentCount == 50){
                model.moviePlayingNow.forEach{
                    item in

                    let video = ViewModelVideos()
                    
                    video.retreiveData(type: .MoviePlaying, itemId: item.id)
                    
                    video.refreshData = {
                        [weak self] () in
                        expectation.fulfill()
                        totalvideos.append(contentsOf: video.data)
                        let error = video.data.filter{$0.site != "YouTube"}
                        
                        if error.count > 0{
                             XCTFail("ERROR \(item.id) \(item.name) \(error.first!.site)")
                        }
                    }
                }
            }
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
            XCTAssert(totalvideos.filter{$0.site == "YouTube"}.count == totalvideos.count)

            print(model.moviePlayingNow.count)
            print(model.moviePlayingNowIndex)
            print(totalCount)
            print("\totalVideos \(totalvideos.count)")
        }
    }*/
    
    //We just want to test we can at least parse our data
    func testMoviePlaying() throws {
        let model = ViewModelList()
        let expectation = self.expectation(description: "Waiting to fetch")
        expectation.expectedFulfillmentCount = 500
        expectation.assertForOverFulfill = false
        model.retreiveDataList(type: .MoviePlaying)
        for _ in 1...49 {
            model.retreiveMoreDataList(type: .MoviePlaying)
        }
        
        var currentCount = 0
        var totalCount = 0
        
        model.refreshData = {
            _ in
            expectation.fulfill()
            
            currentCount = currentCount + 1
            
            if(currentCount == 50){
                model.moviePlayingNow.forEach{
                    item in

                    let detail = ViewModelDetail()

                    detail.retreiveData(type: .MoviePlaying, itemId: item.id)
                    
                    detail.refreshData = {
                        [weak self] () in
                        expectation.fulfill()
                        totalCount = totalCount + 1
                    }
                }
            }
        }
        
        waitForExpectations(timeout: 10) { error in
                XCTAssertNil(error)
            print(model.moviePlayingNow.count)
            print(model.moviePlayingNowIndex)
            print(totalCount)
        }
    }

    //We just want to test we can at least parse our data
    func testMoviePopular() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let model = ViewModelList()
        let expectation = self.expectation(description: "Waiting to fetch")
        expectation.expectedFulfillmentCount = 500
        expectation.assertForOverFulfill = false
        model.retreiveDataList(type: .MoviePopular)
        for _ in 1...49 {
            model.retreiveMoreDataList(type: .MoviePopular)
        }
        
        var currentCount = 0
        var totalCount = 0
        
        model.refreshData = {
            _ in
            expectation.fulfill()
            
            currentCount = currentCount + 1
            
            if(currentCount == 50){
                model.moviePopular.forEach{
                    item in

                    let detail = ViewModelDetail()

                    detail.retreiveData(type: .MoviePopular, itemId: item.id)
                    
                    detail.refreshData = {
                        [weak self] () in
                        expectation.fulfill()
                        totalCount = totalCount + 1
                    }
                }
            }
        }
        
        waitForExpectations(timeout: 10) { error in
                XCTAssertNil(error)
            print(model.moviePopular.count)
            print(model.moviePopularIndex)
            print(totalCount)
        }
    }

    //We just want to test we can at least parse our data
    func testSeriePlaying() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let model = ViewModelList()
        let expectation = self.expectation(description: "Waiting to fetch")
        expectation.expectedFulfillmentCount = 500
        expectation.assertForOverFulfill = false
        model.retreiveDataList(type: .SeriePlaying)
        for _ in 1...49 {
            model.retreiveMoreDataList(type: .SeriePlaying)
        }
        
        var currentCount = 0
        var totalCount = 0
        
        model.refreshData = {
            _ in
            expectation.fulfill()
            
            currentCount = currentCount + 1
            
            if(currentCount == 50){
                model.seriePlayingNow.forEach{
                    item in

                    let detail = ViewModelDetail()

                    detail.retreiveData(type: .SeriePlaying, itemId: item.id)
                    
                    detail.refreshData = {
                        [weak self] () in
                        expectation.fulfill()
                        totalCount = totalCount + 1
                    }
                }
            }
        }
        
        waitForExpectations(timeout: 10) { error in
                XCTAssertNil(error)
            print(model.seriePlayingNow.count)
            print(model.seriePlayingNowIndex)
            print(totalCount)
        }
    }
    
    //We just want to test we can at least parse our data
    func testSeriePopular() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let model = ViewModelList()
        let expectation = self.expectation(description: "Waiting to fetch")
        expectation.expectedFulfillmentCount = 500
        expectation.assertForOverFulfill = false
        model.retreiveDataList(type: .SeriePopular)
        for _ in 1...49 {
            model.retreiveMoreDataList(type: .SeriePopular)
        }
        
        var currentCount = 0
        var totalCount = 0
        
        model.refreshData = {
            _ in
            expectation.fulfill()
            
            currentCount = currentCount + 1
            
            if(currentCount == 50){
                model.seriePopular.forEach{
                    item in

                    let detail = ViewModelDetail()

                    detail.retreiveData(type: .SeriePopular, itemId: item.id)
                    
                    detail.refreshData = {
                        [weak self] () in
                        expectation.fulfill()
                        totalCount = totalCount + 1
                    }
                }
            }
        }
        
        waitForExpectations(timeout: 10) { error in
                XCTAssertNil(error)
            print(model.seriePopular.count)
            print(model.seriePopularIndex)
            print(totalCount)
        }
    }
}
