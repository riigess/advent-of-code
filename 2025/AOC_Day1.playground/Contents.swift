import Foundation

enum FilePart: String {
    case Input = "input.txt"
    case Sample = "sample.txt"
}

struct Row {
    let dir:String
    let inc:Int
}

struct FileReader {
    func readFile(filename:String) -> [String] {
        do {
            let filePath = ""
            let read = try String(contentsOfFile: filePath + filename, encoding: .utf8)
            return read.split(separator: "\n").map { String($0) }
        } catch {
            print(error)
            return []
        }
    }
}

struct PartOne {
    private var pos:Int
    private var zeroCount:Int
    init() {
        self.pos = 50
        self.zeroCount = 0
    }
    
    mutating func turnLeft(by:Int) -> Int {
        self.pos -= by
        if self.pos < 0 {
            self.pos %= 100
        }
        return self.pos
    }
    
    mutating func turnRight(by:Int) -> Int {
        self.pos += by
        if self.pos >= 100 {
            self.pos %= 100
        }
        return self.pos
    }
    
    mutating func solve(filename:FilePart = .Sample) {
        let reader = FileReader()
        let input = reader.readFile(filename: filename.rawValue)
        var temp:Row = Row(dir: "L", inc: 0)
        for line in input {
            temp = Row(dir: line.first?.uppercased() ?? "L", inc: Int(line.dropFirst().lowercased())!)
            if temp.dir == "L" {
                turnLeft(by: temp.inc)
            } else if temp.dir == "R" {
                turnRight(by: temp.inc)
            }
            if self.pos == 0 {
                self.zeroCount += 1
            }
        }
        print(zeroCount)
    }
}

struct PartTwo {
    private var pos:Int
    private var zeroClickCount:Int
    
    init() {
        self.pos = 50
        self.zeroClickCount = 0
    }
    
    mutating func turnLeft(by:Int = 0) -> Int {
        self.pos -= by
        if self.pos < 0 {
            self.zeroClickCount += abs(Int(self.pos / 100))
            self.pos %= 100
        }
        return self.pos
    }
    
    mutating func turnRight(by:Int = 0) -> Int {
        self.pos += by
        if self.pos >= 100 {
            self.zeroClickCount += abs(Int(self.pos / 100))
            self.pos %= 100
        }
        return self.pos
    }
    
    mutating func solve(filename:FilePart = .Sample) {
        let reader = FileReader()
        let input = reader.readFile(filename: filename.rawValue)
        var temp:Row = Row(dir: "L", inc: 0)
        var posTemp = 0
        for line in input {
            temp = Row(dir: String(line.first!),
                       inc: Int(line.dropFirst())!)
            if temp.dir == "L" {
                posTemp = turnLeft(by: temp.inc)
//                print(line, posTemp, zeroClickCount)
            } else if temp.dir == "R" {
                posTemp = turnRight(by: temp.inc)
//                print(line, posTemp, zeroClickCount)
            }
        }
        print(self.zeroClickCount)
    }
}

print("Part One:")
var partOne = PartOne()
partOne.solve(filename: .Input)

///TODO: Fix Part Two, this should be 6099 as the response, not 4963.. Not sure what's going on here.
print("\nPart Two:")
var partTwo = PartTwo()
partTwo.solve(filename: .Input)
