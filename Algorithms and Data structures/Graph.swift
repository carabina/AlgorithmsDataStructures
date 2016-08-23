//
//  Graph.swift
//  Algorithms and Data structures
//
//  Created by Paul Kraft on 09.08.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import Foundation

public protocol Graph {
	init()
	var vertices : Set<Int> { get }
	var edges : [(start: Int, end: Int, weight: Int)] { get set }
	subscript(start: Int) -> [(end: Int, weight: Int)] { get }
	subscript(start: Int, end: Int) -> Int? { get set }
}

extension Graph {
	
	public init(_ edges: (start: Int, end: Int, weight: Int)...) {
		self.init()
		self.edges = edges
	}
	
	public func convert(to: Graph.Type) -> Graph {
		var a = to.init()
		a.edges = self.edges
		return a
	}
}

public func == (lhs: Graph, rhs: Graph) -> Bool {
	let le = lhs.edges
	let re = rhs.edges
	guard le.count == re.count else { return false }
	var sl = Set<HashableEdge>()
	var sr = Set<HashableEdge>()
	for i in le.indices {
		sl.insert(HashableEdge(value: le[i]))
		sr.insert(HashableEdge(value: re[i]))
	}
	return sl == sr
}

private struct HashableEdge : Hashable {
	var value : (start: Int, end: Int, weight: Int)
	var hashValue: Int {
		return (value.start << 32) | value.end
	}
}

private func == (lhs: HashableEdge, rhs: HashableEdge) -> Bool {
	return lhs.value == rhs.value
}







