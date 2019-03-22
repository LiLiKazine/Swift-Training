//
//  MonkeyPinchTests.swift
//  MonkeyPinchTests
//
//  Created by LiLi Kazine on 2019/3/1.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import XCTest

class RBTreeTests: XCTestCase {
    
    let tree = RBTree(initial: 8)


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let l = Node<Int>(val: 3, isRed: true, parent: tree.root)
        let ll = Node<Int>(val: 2, isRed: false, parent: l)
        let lr = Node<Int>(val: 5, isRed: false, parent: l)
//        let lrl = Node<Int>(val: 4, isRed: true, parent: lr)
//        let lrr = Node<Int>(val: 6, isRed: true, parent: lr)
        let r = Node<Int>(val: 12, isRed: false, parent: tree.root)
        let rl = Node<Int>(val: 9, isRed: true, parent: r)
        let rr = Node<Int>(val: 19, isRed: true, parent: r)
//        let rrl = Node<Int>(val: 17, isRed: true, parent: rr)
        tree.root.left = l
        l.left = ll
        l.right = lr
//        lr.left = lrl
//        lr.right = lrr
        tree.root.right = r
        r.left = rl
        r.right = rr
//        rr.left = rrl
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        
        
    }
    
    func testRotateLeft() {
        do {
            try tree.rotateLeft(node: tree.root)
            let queue = tree.printTree()
            print(queue)
        } catch let e {
            print(e)
        }
    }
    
    func testRotateRight() {
        do {
            try tree.rotateRight(node: tree.root)
            let queue = tree.printTree()
            print(queue)
        } catch let e {
            print(e)
        }
    }
    
    func testFindUncle() {
        let uncle = tree.getUncle(of: tree.root.left!.right!)
        let uncleNil = tree.getUncle(of: tree.root.right!)
        print("\(String(describing: uncle)) \(String(describing: uncleNil))")
    }
    
    func testAdd() {
        do {
            _ = try tree.add(val: 7)
            let node = tree.printTree()
            print(node)
        } catch let err {
            print(err)
        }
    }
    
    func testDelete() {
        do {
            let _ = try tree.delete(val: 2, in: nil)
            let node = tree.printTree()
            print(node)
        } catch let err {
            print(err)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}



class Node<T: Comparable>: Comparable {
    
    static func < (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.val < rhs.val
    }
    
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.val == rhs.val
    }
    
    var val: T
    var parent: Node<T>?
    var isRed: Bool
    var left: Node?
    var right: Node?
    
    init(val: T, isRed: Bool = true, parent: Node<T>?) {
        self.val = val
        self.isRed = isRed
        self.parent = parent
    }
}

class Queue<T> {
    private var queue = Array<T?>()
    
    var isEmpty: Bool {
        return size == 0
    }
    
    var size: Int {
        return queue.count
    }
    
    // if all the values in queue are nil
    var allNil: Bool {
        return valCount == 0
    }
    
    // num of value that's not nil
    var valCount: Int = 0
    
    func push(in val: T?) {
        if val != nil {
            valCount += 1
        }
        queue.append(val)
    }
    
    func pop() -> T? {
        if queue.count > 0 {
            let val: T? = queue.remove(at: 0)
            if val != nil {
                valCount -= 1
            }
            return val
        } else {
            return nil
        }
    }
}

class RBTree<T: Comparable> {
    
    enum TreeErrors: Error {
        case OperationError(desc: String)
        case MissNodeError(desc: String)
        case NodeExistsError(desc: String)
        case UnknowError(desc: String)
    }
    
    var root: Node<T>
    
    init(initial: T) {
        self.root = Node<T>(val: initial, isRed: false, parent: nil)
    }
    
    func find(val: T, in tree: Node<T>?) -> Node<T>? {
        var copy: Node<T>?
        if tree == nil {
            copy = root
        } else {
            copy = tree
        }
        while copy != nil {
            if copy!.val == val {
                return copy
            } else if copy!.val > val {
                copy = copy!.left
            } else {
                copy = copy?.right
            }
        }
        return nil
    }
    
    func getSibling(of node: Node<T>) -> Node<T>? {
        guard let parent = node.parent else { return nil }
        if parent.left == node  {
            return parent.right
        } else {
            return parent.left
        }
    }
    
    func getUncle(of node: Node<T>) -> Node<T>? {
        guard let parent = node.parent, let ancestor = parent.parent else { return nil }
        if ancestor.left == parent {
            return ancestor.right
        } else {
            return ancestor.left
        }
    }
    
    func isBlack(node: Node<T>?) -> Bool {
        return node == nil || !node!.isRed
    }
    
    func isRoot(node: Node<T>?) -> Bool {
        return node != nil && node?.parent == nil
    }
    
    
    func add(val: T) throws -> Node<T> {
        var copy: Node<T>? = root
        var parent = copy?.parent
        
        while copy != nil {
            if copy!.val == val {
                throw TreeErrors.NodeExistsError(desc: "Node \(val) already exists.")
            }
            parent = copy
            if copy!.val > val {
                copy = copy!.left
            } else {
                copy = copy!.right
            }
        }
        guard let insertionParent = parent else {
            throw TreeErrors.UnknowError(desc: "Unknow error.")
        }
        let node = Node(val: val, isRed: true, parent: nil)
        if insertionParent.val > val {
            insertionParent.left = node
            node.parent = insertionParent
        } else {
            insertionParent.right = node
            node.parent = insertionParent
        }
        fixInsert(node: node)
        return root
    }
    
    func delete(val: T, in tree: Node<T>?) throws {
        
        guard let node = find(val: val, in: tree) else {
            throw TreeErrors.MissNodeError(desc: "Cannot find node \(val)")
        }
        
        if node.left == nil && node.right == nil {
            guard let parent = node.parent else {
                throw TreeErrors.OperationError(desc: "You are to destroy this tree by pull out the root!")
            }
            if parent.left == node {
                parent.left = nil
            } else {
                parent.right = nil
            }
            if !node.isRed {
                // repair
                fixDeletion(node: nil, parent: parent)
            }
        } else if (node.left != nil) != (node.right != nil) {
            let substitute = node.left == nil ? node.right! : node.left!
            node.val = substitute.val
            node.left = nil
            node.right = nil
            if !node.isRed && !substitute.isRed {
                // repair
                fixDeletion(node: node, parent: node.parent)
            } else if node.isRed && !substitute.isRed {
                node.isRed.toggle()
            }
        } else {
            if let substitute = findPredecessor(of: node) {
                let val = node.val
                node.val = substitute.val
                substitute.val = val
                try delete(val: substitute.val, in: substitute.parent)
            } else {
                
            }
        }
    }
    
    func fixDeletion(node: Node<T>?, parent: Node<T>?) {
        guard let parent = parent, let sibling = parent.left == node ? parent.right : parent.left else { return }
        if sibling.isRed {
            // turn parent to red
            parent.isRed.toggle()
            // turn sibling to black
            sibling.isRed.toggle()
            do {
                if parent.left == sibling {
                    try rotateRight(node: parent)
                } else {
                    try rotateLeft(node: parent)
                }
            } catch let err {
                print(err)
            }
            fixDeletion(node: node, parent: parent)
        } else {
            // sibling is black
            if (sibling.left == nil || !sibling.left!.isRed) && (sibling.right == nil || !sibling.right!.isRed) {
                // both sibling's children are black
                sibling.isRed.toggle()
                if parent.isRed {
                    parent.isRed.toggle()
                } else {
                    // parent become double black
                    fixDeletion(node: parent, parent: parent.parent)
                }
            } else if parent.left == sibling && sibling.right?.isRed == true && (sibling.left == nil || !sibling.left!.isRed) {
                // turn sibling red
                sibling.isRed.toggle()
                // turn sibling's right child black
                sibling.right?.isRed.toggle()
                do {
                    try rotateLeft(node: sibling)
                } catch let err {
                    print(err)
                }
                fixDeletion(node: node, parent: parent)
            } else if parent.right == sibling && sibling.left?.isRed == true && (sibling.right == nil || !sibling.right!.isRed) {
                sibling.isRed.toggle()
                sibling.left?.isRed.toggle()
                do {
                    try rotateRight(node: sibling)
                } catch let err {
                    print(err)
                }
                fixDeletion(node: node, parent: parent)
                
            } else if parent.left == sibling && sibling.left != nil && sibling.left!.isRed {
                sibling.isRed = parent.isRed
                parent.isRed = false
                sibling.left!.isRed.toggle()
                do {
                    try rotateRight(node: parent)
                } catch let err {
                    print(err)
                }
                
            } else if parent.right == sibling && sibling.right != nil && sibling.right!.isRed {
                sibling.isRed = parent.isRed
                parent.isRed = false
                sibling.right!.isRed.toggle()
                do {
                    try rotateLeft(node: parent)
                } catch let err {
                    print(err)
                }
            }
        }
        
    }
    
    func findPredecessor(of node: Node<T>) -> Node<T>? {
        var copy = node.left
        if copy == nil {
            return copy
        }
        while copy?.right != nil {
            copy = copy?.right
        }
        return copy
    }
    
    func replace(replace val1: T, with val2: T) throws {
        if let node = find(val: val1, in: nil) {
            node.val = val2
        } else {
            throw TreeErrors.MissNodeError(desc: "Cannot find specific node \(val1).")
        }
    }
    
    func changeColor(node: Node<T>) {
        node.isRed.toggle()
    }
    
    func rotateLeft(node: Node<T>) throws {
        
        guard let right = node.right else {
            throw TreeErrors.MissNodeError(desc: "Miss right child")
        }
        
        if let parent = node.parent {
            if parent.left == node {
                parent.left = right
            } else {
                parent.right = right
            }
            right.parent = parent
        } else {
            // node is root
            right.parent = nil
            // update root
            root = right
        }
        right.left?.parent = node
        node.right = right.left
        node.parent = right
        right.left = node
    }
    
    func rotateRight(node: Node<T>) throws {
        guard let left = node.left else {
            throw TreeErrors.MissNodeError(desc: "Miss left child")
        }
        if let parent = node.parent {
            left.parent = parent
            if parent.left == node {
                parent.left = left
            } else {
                parent.right = left
            }
        } else {
            // node is root
            left.parent = nil
            // update root
            root = left
        }
        left.right?.parent = node
        node.left = left.right
        node.parent = left
        left.right = node
    }
    
    func fixInsert(node: Node<T>) {
        guard let parent = node.parent else {
            if node.isRed {
                // root must be black
                node.isRed.toggle()
            }
            return
        }
        
        guard parent.isRed else {
            return
        }
        
        let uncle = getUncle(of: node)
        if uncle != nil && uncle!.isRed {
            // turn parent & uncle to black
            parent.isRed.toggle()
            uncle!.isRed.toggle()
            // turn grandpa to red
            parent.parent?.isRed.toggle()
            fixInsert(node: parent.parent!)
            return
        }
        if uncle == nil || !uncle!.isRed {
            guard let grandpa = parent.parent else { return }
            do {
                if parent.left == node {
                    if grandpa.left == parent {
                        // turn grandpa red
                        grandpa.isRed.toggle()
                        // turn parent black
                        parent.isRed.toggle()
                        try rotateRight(node: grandpa)
                        fixInsert(node: parent)
                        return
                    }
                    if grandpa.right == parent {
                        try rotateRight(node: parent)
                        return
                    }
                }
                
                if parent.right == node {
                    if grandpa.left == parent {
                        try rotateLeft(node: parent)
                        fixInsert(node: parent)
                        return
                    }
                    if grandpa.right == parent {
                        grandpa.isRed.toggle()
                        parent.isRed.toggle()
                        try rotateLeft(node: grandpa)
                        return
                    }
                }
            } catch let err {
                print(err)
            }
        }
        
    }
    
    
    func printTree() -> Queue<T?> {
        let mainQueue = Queue<T?>()
        let nodeQueue = Queue<Node<T>>()
        nodeQueue.push(in: root)
        levTraversal(in: mainQueue, from: nodeQueue)
        return mainQueue
    }
    
    func levTraversal(in mainQueue: Queue<T?>, from nodeQueue: Queue<Node<T>>) {
        if nodeQueue.allNil {
            return
        }
        var count = nodeQueue.size
        while count > 0 {
            count -= 1
            let node = nodeQueue.pop()
            mainQueue.push(in: node?.val)
            nodeQueue.push(in: node?.left)
            nodeQueue.push(in: node?.right)
        }
        levTraversal(in: mainQueue, from: nodeQueue)
    }
    
}
