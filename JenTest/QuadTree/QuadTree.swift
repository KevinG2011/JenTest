//
//  QuadTree.swift
//  JenTest
//
//  Created by lijia on 2021/11/9.
//  Copyright © 2021 MJHF. All rights reserved.
//

import UIKit

private final class Node {
    let maxItemCapcity = 4
    var region: CGRect
    var points: [CGPoint] = []
    var quad: Quad?
    
    init(region: CGRect, points: [CGPoint] = [], quad: Quad? = nil) {
        self.region = region
        self.quad = quad
        self.points = points
        self.points.reserveCapacity(maxItemCapcity)
        precondition(self.points.count <= maxItemCapcity)
    }
    
    func copy() -> Node {
        Node(region: region, points: points, quad: quad?.copy())
    }
    
    func subdivide() {
        precondition(quad == nil, "Can't subdivide a node already subdivide")
        quad = Quad(region: region)
    }
    
    func insert(_ point: CGPoint) -> Bool {
        if let quad = quad {
            return quad.northWest.insert(point) || quad.northEast.insert(point) || quad.southWest.insert(point) || quad.southEast.insert(point)
        }
        
        if points.count == maxItemCapcity {
            subdivide()
            return insert(point)
        }
        
        guard region.contains(point) else {
            return false
        }
        
        points.append(point)
        return true
    }
    
    func find(in searchRegion: CGRect) -> [CGPoint] {
        guard region.intersects(searchRegion) else {
            return []
        }
        
        var found = points.filter { searchRegion.contains($0) }
        if let quad = quad {
            found += quad.all.flatMap{ $0.find(in: searchRegion) }
        }
        return found
    }
}

struct Quad {
    fileprivate var northWest: Node
    fileprivate var northEast: Node
    fileprivate var southWest: Node
    fileprivate var southEast: Node
    fileprivate var all: [Node] { [northWest, northEast, southWest, southEast] }
    
    init(region: CGRect) {
        let halfWidth = region.size.width * 0.5;
        let halfHeight = region.size.height * 0.5;
        
        northWest = Node(region: CGRect(x: region.origin.x, y: region.origin.y, width: halfWidth, height: halfHeight))
        northEast = Node(region: CGRect(x: region.origin.x + halfWidth, y: region.origin.y, width: halfWidth, height: halfHeight))
        southWest = Node(region: CGRect(x: region.origin.x, y:region.origin.y + halfHeight, width: halfWidth, height: halfHeight))
        southEast = Node(region: CGRect(x: region.origin.x + halfWidth, y: region.origin.y + halfHeight, width: halfWidth, height: halfHeight))
    }
    
    fileprivate init(northWest: Node, northEast: Node, southWest: Node, southEast: Node) {
        self.northWest = northWest
        self.northEast = northEast
        self.southWest = southWest
        self.southEast = southEast
    }
    
    fileprivate func copy() -> Quad {
        Quad(northWest: northWest.copy(),
             northEast: northEast.copy(),
             southWest: southWest.copy(),
             southEast: southEast.copy())
    }
}


struct QuadTree {
    private var root: Node
    private var count = 0
    
    init(region: CGRect) {
        root = Node(region: region)
    }
    
    func find(in searchRegion: CGRect) -> [CGPoint] {
        root.find(in: searchRegion)
    }
    
    func points() -> [CGPoint] {
        find(in: root.region)
    }
    
    private func collectRegions(from node: Node) -> [CGRect] {
        var result = [root.region]
        if let quad = root.quad {
            result += quad.all.flatMap{ collectRegions(from: $0) }
        }
        return result
    }
    
    func regions() -> [CGRect] {
        collectRegions(from: root)
    }
    
    @discardableResult
    mutating func insert(_ point: CGPoint) -> Bool {
        if !isKnownUniquelyReferenced(&root) {
            root = root.copy()
        }
        
        guard root.insert(point) else {
            return false
        }
        count += 1
        return true
    }
}
