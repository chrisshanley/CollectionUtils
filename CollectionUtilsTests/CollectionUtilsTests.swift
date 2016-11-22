//
//  CollectionUtilsTests.swift
//  CollectionUtilsTests
//
//  Created by christopher shanley on 11/22/16.
//  Copyright © 2016 christopher shanley. All rights reserved.
//

import XCTest
@testable import CollectionUtils

class TestDif:Diffable, CustomStringConvertible
{
    var id:String
    init( _ id:String )
    {
        self.id = id
    }
    
    var description:String
    {
        return "<TestDif> id: \(self.id)"
    }
}

class CollectionUtilsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDiffaleV1()
    {
        let local  = [TestDif("1"), TestDif("2"),TestDif("3"),TestDif("4")]
        let server = [TestDif("1"), TestDif("2"),TestDif("6"),TestDif("4"), TestDif("7")]
        
        let dif = local.diff(serverList: server)
        let a = dif.create.sorted(by:{$0.id < $1.id}).map({$0.id})
        let b = dif.update.sorted(by:{$0.id < $1.id}).map({$0.id})
        let c = dif.delete.sorted(by:{$0.id < $1.id}).map({$0.id})
        
        XCTAssertEqual(a, ["6", "7"], "create not correct")
        XCTAssertEqual(b, ["1", "2", "4"], "create not correct")
        XCTAssertEqual(c, ["3"], "create not correct")
    }
    
    
    func testDiffaleV2()
    {
        let local  = [TestDif]()
        let server = [TestDif("1"), TestDif("2"),TestDif("3"),TestDif("4")]
        
        let dif = local.diff(serverList: server)
        let a = dif.create.sorted(by:{$0.id < $1.id}).map({$0.id})
        let b = dif.update.sorted(by:{$0.id < $1.id}).map({$0.id})
        let c = dif.delete.sorted(by:{$0.id < $1.id}).map({$0.id})
        
        XCTAssertEqual(a, ["1", "2", "3", "4"], "create not correct")
        XCTAssertEqual(b, [], "delte not correct")
        XCTAssertEqual(c, [], "create not correct")
    }
    
    func testDiffaleV3()
    {
        let local  = [TestDif("1"), TestDif("2"), TestDif("20")]
        let server = [TestDif("10"), TestDif("20"),TestDif("6"),TestDif("4"), TestDif("7")]
        
        let dif = local.diff(serverList: server)
        let a = dif.create.sorted(by:{$0.id < $1.id}).map({$0.id})
        let b = dif.update.sorted(by:{$0.id < $1.id}).map({$0.id})
        let c = dif.delete.sorted(by:{$0.id < $1.id}).map({$0.id})
        
        XCTAssertEqual(a, ["10", "4", "6", "7" ], "create not correct")
        XCTAssertEqual(b, ["20"], "update not correct")
        XCTAssertEqual(c, ["1", "2"], "delete not correct")
    }
    
    
    func testDiffaleV4()
    {
        let local  = [TestDif("1"), TestDif("2"),TestDif("6"),TestDif("4"), TestDif("7")]
        let server = [TestDif("10"), TestDif("20")]
        
        let dif = local.diff(serverList: server)
        let a = dif.create.sorted(by:{$0.id < $1.id}).map({$0.id})
        let b = dif.update.sorted(by:{$0.id < $1.id}).map({$0.id})
        let c = dif.delete.sorted(by:{$0.id < $1.id}).map({$0.id})
        
        XCTAssertEqual(a, ["10", "20"], "create not correct")
        XCTAssertEqual(b, [], "update not correct")
        XCTAssertEqual(c, ["1", "2", "4", "6", "7"], "delete not correct")
    }
}
