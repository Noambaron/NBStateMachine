# NBStateMachine
Simple State Machine written in Swift

[![Version](https://img.shields.io/cocoapods/v/NBStateMachine.svg?style=flat)](http://cocoapods.org/pods/NBStateMachine)
[![License](https://img.shields.io/cocoapods/l/NBStateMachine.svg?style=flat)](http://cocoapods.org/pods/NBStateMachine)
[![Platform](https://img.shields.io/cocoapods/p/NBStateMachine.svg?style=flat)](http://cocoapods.org/pods/NBStateMachine)


## Requirements

* iOS 9.0+
* Xcode 7+

## Example App 

To run the example project, clone the repo, and run


## Installation

NBStateMachine is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```objective-c
pod "NBStateMachine"
```

## Set States


```objective-c
//states
let stateLyingDown = State(name: "Lying Down")
let stateStanding = State(name: "Standing")
let stateSitting = State(name: "Sitting Down")
let stateRunning = State(name: "Running")

```

## Set Events

```objective-c

//events
let eventSitDown = Event(eventName: "Sit Down", sourceStates: [stateStanding, stateLyingDown], destinationState: stateSitting)
eventSitDown.willFireEvent = { (event:Event) -> Bool in
print("I'm about to sit down")
return true
}
eventSitDown.didFireEvent = { (event:Event) -> Void in
print("I'm am siting down")
}



let eventStandUp = Event(eventName: "Stand Up", sourceStates: [stateSitting, stateRunning], destinationState: stateStanding)
eventStandUp.willFireEvent = { (event:Event) -> Bool in
print("I'm about to Stand")
return true
}
eventStandUp.didFireEvent = { (event:Event) -> Void in
print("I'm am Standing")
}


let eventStartRunning = Event(eventName: "Start Running", sourceStates: [stateStanding, stateRunning], destinationState: stateRunning)
eventStartRunning.willFireEvent = { (event:Event) -> Bool in
print("I'm about to Start running")
return true
}
eventStartRunning.didFireEvent = { (event:Event) -> Void in
print("I'm am Running")
}
```

## Initiate NBStateMachine

```objective-c

//initiate NBStateMachine
let machine = NBStateMachine(initialState: stateLyingDown)
machine.addStates([stateSitting, stateRunning, stateStanding])
machine.addEvents([eventSitDown, eventStandUp, eventStartRunning])

```

## Fire an event

```objective-c
//fire an event
let transition = machine.fireEvent(eventSitDown) //try also eventStandUp, eventStartRunning

```

## Introspec a transition

```objective-c
print("transition from State:\(transition.sourceState.name)  to State:\(transition.destinationState.name) was successful :\(transition.successful) with error:\(transition.error?.description)")
```


## Collaboration
Feel free to collaborate with ideas, issues and/or pull requests.


## Author

Noam Bar-on, https://www.linkedin.com/in/noambaron

## License

The MIT License (MIT)

Copyright (c) 2015 Noam Bar-on.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

<!--=======-->
<!--Simple State Machine written in Swift-->
