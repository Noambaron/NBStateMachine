//
//  Event.swift
//  NBStateMachine
//
//  Created by Noam on 10/13/15.
//  Copyright © 2015 Noam. All rights reserved.
//

import Foundation


public class Transition {
    
    public var successful: Bool
    public var sourceState: State
    public var destinationState: State
    public var error: NSError?
    
    init(successful: Bool, sourceState: State, destinationState: State, error: NSError?) {

        self.successful = successful
        self.sourceState = sourceState
        self.destinationState = destinationState
        self.error = error
    }
}



public class Event: NSObject {
    
    public var name : String
    public var sourceStates: Array<State>
    public var destinationState: State
    
    public var willFireEvent: ( (event : Event) -> Bool )? //return no in the block to prevent the event from firing
    public var didFireEvent: ( (event : Event) -> Void )?

    public init(eventName: String, sourceStates sources: Array<State>, destinationState destination: State) {
        
        name = eventName
        sourceStates = sources
        destinationState = destination
        super.init()
    }

}

public func ==(lhs:Event,rhs:Event) -> Bool {
    return lhs.name == rhs.name
}





















