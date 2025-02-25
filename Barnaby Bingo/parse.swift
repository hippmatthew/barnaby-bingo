//
//  parse.swift
//  MidsomerBingo
//
//  Created by Groot on 2/19/25.
//

import Foundation

struct BingoFile {
    let magic: UInt64
    let version: UInt16
    let count: UInt64
    let items: [String]
}

func parse(_ data: Data) throws -> BingoFile {
    var offset = 0
    
    func readUInt16() -> UInt16 {
        defer { offset += 2 }
        return data.subdata(in: offset..<offset+2).withUnsafeBytes { $0.load(as: UInt16.self) }
    }
    
    func readUInt64() -> UInt64 {
        defer { offset += 8 }
        return data.subdata(in: offset..<offset+8).withUnsafeBytes { $0.load(as: UInt64.self) }
    }
    
    func readString() -> String? {
        let length = Int(readUInt64())
        guard offset + length <= data.count else { return nil }
        
        let str = data.subdata(in: offset..<offset + length)
        offset += length
        
        return String(data: str, encoding: .utf8)
    }
    
    let magic = readUInt64()
    if (magic != 0x62696E676F) {
        throw NSError(domain: "ParseError", code: 1, userInfo: [NSLocalizedDescriptionKey: "incorrect file format"])
    }
        
    let version = readUInt16()
    if (version != 0x1) {
        throw NSError(domain: "ParseError", code: 10, userInfo: [NSLocalizedDescriptionKey: "incorrect protocol version"])
    }
        
    
    let count = readUInt64()
    
    var items: [String] = []
    
    for _ in 0..<count {
        if let text = readString() {
            items.append(text)
        }
        else {
            throw NSError(domain: "ParseError", code: 11, userInfo: [NSLocalizedDescriptionKey: "failed to read item"])
        }
    }
    
    if (offset != data.count) {
        throw NSError(domain: "ParseError", code: 100, userInfo: [NSLocalizedDescriptionKey: "corrupted file"])
    }
    
    return BingoFile(magic: magic, version: version, count: count, items: items)
}
