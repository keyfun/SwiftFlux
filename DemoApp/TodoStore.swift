//
//  TodoStore.swift
//  SwiftFlux
//
//  Created by Kenichi Yonekawa on 8/1/15.
//  Copyright (c) 2015 mog2dev. All rights reserved.
//

import Foundation
import SwiftFlux
import Result

class TodoStore : Store {
    enum TodoEvent {
        case Fetched
        case Created
        case Deleted
    }
    typealias Event = TodoEvent

    let eventEmitter = EventEmitter<TodoStore>()

    private var todos = [Todo]()
    var list: Array<Todo> {
        return todos;
    }

    init() {
        ActionCreator.dispatcher.register(TodoAction.Fetch.self) { (result) in
            switch result {
            case .Success(let box):
                self.todos = box
                self.eventEmitter.emit(TodoEvent.Fetched)
            case .Failure(_):
                break;
            }
        }

        ActionCreator.dispatcher.register(TodoAction.Create.self) { (result) in
            switch result {
            case .Success(let box):
                self.todos.insert(box, atIndex: 0)
                self.eventEmitter.emit(TodoEvent.Created)
            case .Failure(_):
                break;
            }
        }

        ActionCreator.dispatcher.register(TodoAction.Delete.self) { (result) in
            switch result {
            case .Success(let box):
                self.todos.removeAtIndex(box)
                self.eventEmitter.emit(TodoEvent.Deleted)
            case .Failure(_):
                break;
            }
        }
    }
}