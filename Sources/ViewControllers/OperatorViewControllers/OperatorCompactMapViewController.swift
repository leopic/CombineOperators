//
//  OperatorCompactMapViewController.swift
//  CombineOperatorsCore
//
//  Copyright (c) 2020 cocoatoucher user on github.com (https://github.com/cocoatoucher/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit
import Combine

class OperatorCompactMapViewController: BaseOperatorViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subjects = [Subject(title: "Subject", publisher: publisher, inputValues: ["🌟", "✅", nil])]
        
        operators = [Operator(name: "compactMap", description: "value + 💃")]
        
        subscription = compactMappedPublisher.sink(
            receiveCompletion: { [weak self] _ in
                guard let self = self else { return }
                self.setValueFromOperator(value: "finished")
            }, receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.setValueFromOperator(value: "\(value)")
            })
        
        operatorInfo = "Calls a closure with each received element and publishes any returned optional that has a value."
    }
    
    deinit {
        subscription?.cancel()
    }
    
    // MARK: - Private
    
    private let publisher = PassthroughSubject<String?, Never>()
    
    private lazy var compactMappedPublisher: Publishers.CompactMap = {
        return publisher.compactMap { value -> String? in
            if let value = value {
                return "\(value) 💃"
            }
            return nil
        }
    }()
    
    private var subscription: AnyCancellable?
    
}
