//
//  Combine+Utils.swift
//  MiniSuperApp
//
//  Created by Bradley.yoon on 2021/11/14.
//
import Combine
import CombineExt
import Foundation



public class ReadOnlyCurrentValuePublisher<Element>: Publisher {
    public typealias Output = Element
    public typealias Failure = Never

    public var value: Element {
        currentValueReleay.value
    }

    fileprivate let currentValueReleay: CurrentValueRelay<Output>

    fileprivate init(_ initValue: Element) {
        currentValueReleay = CurrentValueRelay(initValue)
    }

    public func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, Element == S.Input {
        currentValueReleay.receive(subscriber: subscriber)
    }

}

public final class CurrentValuePublisher<Element>: ReadOnlyCurrentValuePublisher<Element> {
    typealias Output = Element
    typealias Failure = Never

    override init(_ initValue: Element) {
        super.init(initValue)
    }

    public func send(_ value: Element) {
        currentValueReleay.accept(value)
    }
}
