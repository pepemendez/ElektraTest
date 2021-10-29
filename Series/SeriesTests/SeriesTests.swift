//
//  SeriesTests.swift
//  SeriesTests
//
//  Created by Jose Mendez on 22/10/21.
//

import XCTest
@testable import Series

class SeriesTests: XCTestCase {

    let model = ViewModelList()
    
    override func setUp(){
        let expectation = self.expectation(description: "Waiting to fetch")
    
        let group = DispatchGroup()
        
        for type in [.MoviePlaying, ItemType.MoviePopular, .SeriePlaying, .SeriePopular] {
            group.enter()
            model.retreiveDataList(type: type)
            
            for _ in 1...50 {
                group.enter()
                model.retreiveMoreDataList(type: type)
            }
        }

        model.refreshData = {
            _ in
            group.leave()
        }
        
        group.notify(queue: .main) {
            print(#function)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60) { error in
            /*print("moviePlayingNow", self.model.moviePlayingNow.count)
            print("moviePlayingNowIndex", self.model.moviePlayingNowIndex)
            
            print("moviePopular", self.model.moviePopular.count)
            print("moviePopularIndex", self.model.moviePopularIndex)

            print("seriePlayingNow", self.model.seriePlayingNow.count)
            print("seriePlayingNowIndex", self.model.seriePlayingNowIndex)

            print("seriePopular", self.model.seriePopular.count)
            print("seriePopularIndex", self.model.seriePopularIndex)*/
        }
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //We just want to test we can at least parse our data
    func testMoviePlaying() throws {
        print(#function)
        let expectation = self.expectation(description: "Waiting to fetch")
        expectation.assertForOverFulfill = false
    
        let group = DispatchGroup()
        
        var details = [ViewModelDetail]()

        for item in model.moviePlayingNow{
            let detail = ViewModelDetail()
            group.enter()
            detail.retreiveData(type: .MoviePlaying, itemId: item.id)
            
            detail.refreshData = {
                group.leave()
            }
            
            details.append(detail)
        }


        group.notify(queue: .main) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 25) { error in
            XCTAssertNil(error)
            print(details.count)
        }
    }
    
    func testMoviePopular() throws {
        print(#function)
        let expectation = self.expectation(description: "Waiting to fetch")
        expectation.assertForOverFulfill = false
    
        let group = DispatchGroup()
        
        var details = [ViewModelDetail]()

        for item in model.moviePopular{
            let detail = ViewModelDetail()
            group.enter()
            detail.retreiveData(type: .MoviePopular, itemId: item.id)
            
            detail.refreshData = {
                group.leave()
            }
            
            details.append(detail)
        }


        group.notify(queue: .main) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 25) { error in
            XCTAssertNil(error)
            print(details.count)
        }
    }
    
    func testSeriePlaying() throws {
        print(#function)
        let expectation = self.expectation(description: "Waiting to fetch")
        expectation.assertForOverFulfill = false
    
        let group = DispatchGroup()
        
        var details = [ViewModelDetail]()

        for item in model.seriePlayingNow{
            let detail = ViewModelDetail()
            group.enter()
            detail.retreiveData(type: .SeriePlaying, itemId: item.id)
            
            detail.refreshData = {
                group.leave()
            }
            
            details.append(detail)
        }


        group.notify(queue: .main) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 25) { error in
            XCTAssertNil(error)
            print(details.count)
        }
    }
    
    func testSeriePopular() throws {
        print(#function)
        let expectation = self.expectation(description: "Waiting to fetch")
        expectation.assertForOverFulfill = false
    
        let group = DispatchGroup()
        
        var details = [ViewModelDetail]()

        for item in model.seriePopular{
            let detail = ViewModelDetail()
            group.enter()
            detail.retreiveData(type: .SeriePopular, itemId: item.id)
            
            detail.refreshData = {
                group.leave()
            }
            
            details.append(detail)
        }


        group.notify(queue: .main) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 25) { error in
            XCTAssertNil(error)
            print(details.count)
        }
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

}
