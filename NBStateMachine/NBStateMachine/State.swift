//
//  State.swift
//  NBStateMachine
//
//  Created by Noam on 10/13/15.
//  Copyright © 2015 Noam. All rights reserved.
//

import Foundation




public class State: NSObject {
    
    /**
    `State` class encapsulates a state value (string), and closure-based callbacks to fire when state machine enters or exits state.
    */
    public let name : String
    public var userInfo:AnyObject?

    public var willEnterStateNamed: ( (enteringStateName : String ) -> Void)?
    public var didEnterStateNamed:  ( (enteringStateName : String ) -> Void)?
    public var willExitStateNamed:  ( (exitingStateName  : String ) -> Void)?
    public var didExitStateNamed:   ( (exitingStateName  : String ) -> Void)?
    
    public init(name: String) {
        self.name = name
    }
    
}