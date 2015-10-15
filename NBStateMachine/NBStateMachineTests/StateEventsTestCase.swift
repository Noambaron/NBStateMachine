//
//  StateEventsTestCase.swift
//  NBStateMachine
//
//  Created by Noam on 10/13/15.
//  Copyright © 2015 Noam. All rights reserved.
//

import XCTest
import NBStateMachine

class StateEventsTestCase: XCTestCase {

    let state = State(name: "0")
    let stateOne = State(name: "1")
    let stateTwo = State(name: "2")
    let stateThree = State(name: "3")
    let stateFour = State(name: "4")
    let stateFive = State(name: "5")

    var machine : NBStateMachine!
    
    override func setUp() {
        super.setUp()
        
        machine = NBStateMachine(initialState: state)
    }

    func testWillEnterBlock() {
        var x = 5
        state.willEnterStateNamed = { _ in
            x = 6
            
        }
        
        machine.addState(state)
        machine.activateStateNamed("0")
        
        XCTAssert(x==6)
    }
    
    func testDidEnterBlock() {

        var x = 1
        stateThree.didEnterStateNamed = { _ in x=2 }
        
        machine.addState(stateThree)
        machine.activateStateNamed(stateThree.name)
        
        XCTAssert(x==2)
    }

}
