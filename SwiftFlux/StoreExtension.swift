//
//  StoreExtension.swift
//
//  Created by Key HUI on 23/11/2015.
//

extension EventEmitter {
    // new add with pass parameters when emit
    public func listen(event: T.Event, handler: ([String:AnyObject]?) -> Void) -> String {
        let nextListenerIdentifier = "EVENT_LISTENER_\(++lastListenerIdentifier)"
        self.eventListeners[nextListenerIdentifier] = EventListenerWithParameters<T>(event: event, handler: handler)
        return nextListenerIdentifier
    }
    
    public func emit(event: T.Event, parameters:[String:AnyObject]?) {
        for (_, value) in self.eventListeners {
            guard let listener = value as? EventListenerWithParameters<T> else { continue }
            guard listener.event == event else { continue }
            listener.handler(paramters: parameters)
        }
    }
}

// new add with pass parameters when emit
internal class EventListenerWithParameters<T: Store> {
    let event: T.Event
    let handler: (paramters:[String:AnyObject]?) -> Void
    
    init(event: T.Event, handler: ([String:AnyObject]?) -> Void) {
        self.event = event
        self.handler = handler
    }
}
