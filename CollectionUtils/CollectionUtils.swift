//
//  CollectionUtils.swift
//  iOS
//
//  Created by christopher shanley on 10/28/16.
//  Copyright © 2016 Chirs Shanley. All rights reserved.
//

import Foundation
public protocol Diffable
{
    var id:String {get}
}

public extension Array where Element:Diffable
{
    var dict:[String:Element]
    {
        let start    = [String:Element]()
        return self.reduce(start) { (current, item) -> [String:Element] in
            var map = current
            map[item.id] = item
            return map
        }
    }
    
    func diff(serverList:[Element])->(update:[Element], create:[Element], delete:[Element] )
    {
        var update   = [Element]()
        var delete   = [Element]()
        
        let local    = self.dict
        var remote   = serverList.dict
        
        for (k, v) in local
        {
            if let match = remote[k]
            {
                update.append(match)
                remote.removeValue(forKey: k)
            }
            else
            {
                delete.append(v)
            }
        }
        
        let create = Array<Element>(remote.values)
        return (update:update, create:create, delete:delete)
    }
    
    var deduped:[Element]
    {
        get
        {
            return Array<Element>(self.dict.values)
        }
    }
}
